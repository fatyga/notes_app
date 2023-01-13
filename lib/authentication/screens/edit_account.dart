import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/notes/domain/services/firestore_service.dart';
import 'package:notes_app/notes/domain/models/models.dart';
import 'package:notes_app/notes/domain/services/storage_service.dart';
import 'package:provider/provider.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _firstName;
  String? _lastName;

  String uploadAvatarStatus = '';
  String error = '';
  bool canClose = true;

  Future<void> _uploadAvatarToFirestore({required String avatarUrl}) async {
    final firestore = Provider.of<FirestoreService>(context, listen: false);

    try {
      await firestore.updateUserAccount({'avatarUrl': avatarUrl});
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> _uploadAvatarToStorage(
      BuildContext context, ImageSource source) async {
    final storage = Provider.of<StorageService>(context, listen: false);

    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        final file = File(pickedImage.path);

        storage.updateAvatar(
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
                case TaskState.canceled:
                  break;
                case TaskState.paused:
                  break;
              }
            });
      } else {
        throw 'Failed to select an image';
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAccount = Provider.of<UserAccount?>(context);
    return Container(
      padding: const EdgeInsets.only(top: 32, left: 12, right: 12),
      child: Column(
        children: <Widget>[
          Text(error, style: TextStyle(color: Theme.of(context).errorColor)),
          const SizedBox(height: 12),
          const Text('Avatar:'),
          const SizedBox(width: 16),
          ElevatedButton(
              onPressed: !canClose
                  ? null
                  : () {
                      setState(() {
                        error = '';
                        uploadAvatarStatus = '';
                      });
                      _uploadAvatarToStorage(context, ImageSource.camera);
                    },
              child: const Text('Upload from camera')),
          const SizedBox(width: 16),
          ElevatedButton(
              onPressed: !canClose
                  ? null
                  : () {
                      setState(() {
                        error = '';
                        uploadAvatarStatus = '';
                      });
                      _uploadAvatarToStorage(context, ImageSource.gallery);
                    },
              child: const Text('Upload from gallery')),
          Text(uploadAvatarStatus),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _firstName ?? userAccount?.firstName,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: (val) => (val != null && val.isEmpty)
                        ? 'Field must not be empty'
                        : null,
                    onChanged: (val) {
                      _firstName = val;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: _lastName ?? userAccount?.lastName,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: (val) => (val != null && val.isEmpty)
                        ? 'Field must not be empty'
                        : null,
                    onChanged: (val) {
                      _lastName = val;
                    },
                  ),
                ],
              )),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: canClose ? () => Navigator.pop(context) : null,
                  child: const Text('cancel')),
              const SizedBox(width: 12),
              ElevatedButton(
                  onPressed: canClose
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            final account = Provider.of<UserAccount?>(context,
                                listen: false);
                            final firestore = Provider.of<FirestoreService>(
                                context,
                                listen: false);

                            await firestore.updateUserAccount({
                              "firstName": _firstName ?? account!.firstName,
                              "lastName": _lastName ?? account!.lastName
                            });

                            Navigator.pop(context);
                          }
                        }
                      : null,
                  child: const Text('update'))
            ],
          ),
        ],
      ),
    );
  }
}
