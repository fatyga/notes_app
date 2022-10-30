import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/core/database/firestore_service.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:notes_app/core/database/storage_service.dart';
import 'package:provider/provider.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  GlobalKey _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;

  String uploadAvatarStatus = '';
  String error = '';
  bool canClose = true;

  Future<void> _uploadAvatarToFirestore({required String avatarUrl}) async {
    final user = Provider.of<User?>(context, listen: false);

    try {
      await FirestoreService()
          .updateUserAccount(user!, {'avatarUrl': avatarUrl});
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> _uploadAvatarToStorage(
      BuildContext context, ImageSource source) async {
    final user = Provider.of<User?>(context, listen: false);

    String avatarUrl = '';

    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        final file = File(pickedImage.path);

        StorageService().updateAvatar(
            uid: user!.uid,
            file: file,
            fn: (TaskSnapshot snap) async {
              switch (snap.state) {
                case TaskState.running:
                  setState(() {
                    canClose = false;
                    uploadAvatarStatus = 'Uploading avatar...';
                  });
                  break;
                case TaskState.success:
                  setState(() {
                    canClose = true;
                    uploadAvatarStatus = 'Aavtar was uploaded successfully';
                  });
                  final avatarUrl = await snap.ref.getDownloadURL();
                  await _uploadAvatarToFirestore(avatarUrl: avatarUrl);
                  break;
                case TaskState.error:
                  setState(() {
                    uploadAvatarStatus = 'Failed to upload avatar..';
                  });
                  break;
              }
            });
      } else {
        throw 'Failed to select an image';
      }
    } catch (e) {
      print(e);
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAccount = Provider.of<UserAccount?>(context);

    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Text(error),
          Row(children: <Widget>[
            Text('Avatar:'),
            const SizedBox(width: 16),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    error = '';
                    uploadAvatarStatus = '';
                  });
                  _uploadAvatarToStorage(context, ImageSource.camera);
                },
                child: const Text('Upload from camera')),
            const SizedBox(width: 16),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    error = '';
                    uploadAvatarStatus = '';
                  });
                  _uploadAvatarToStorage(context, ImageSource.gallery);
                },
                child: const Text('Upload from gallery')),
          ]),
          Text(uploadAvatarStatus),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _firstName ?? userAccount?.firstName,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    onChanged: (val) {
                      _firstName = val;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: _lastName ?? userAccount?.lastName,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    onChanged: (val) {
                      _lastName = val;
                    },
                  ),
                ],
              )),
          ElevatedButton(
              onPressed: canClose
                  ? () async {
                      final user = Provider.of<User?>(context, listen: false);
                      final account =
                          Provider.of<UserAccount?>(context, listen: false);
                      await FirestoreService().updateUserAccount(user!, {
                        "firstName": _firstName ?? account!.firstName,
                        "lastName": _lastName ?? account!.lastName
                      });

                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('done'))
        ],
      ),
    );
  }
}
