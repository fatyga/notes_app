import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/components/avatar.dart';
import 'package:notes_app/core/authentication/auth.dart';
import 'package:notes_app/core/database/firestore_service.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:notes_app/core/database/storage_service.dart';
import 'package:provider/provider.dart';

class UserAccountInfoPage extends StatelessWidget {
  const UserAccountInfoPage({super.key});

  Future<void> _chooseAvatar(BuildContext context) async {
    final user = Provider.of<User?>(context, listen: false);

    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        final file = File(pickedImage.path);

        final avatarUrl =
            await StorageService().updateAvatar(uid: user!.uid, file: file);

        final avatar = await FirestoreService()
            .updateUserAccount(user, {'avatarUrl': avatarUrl});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(leading: AutoLeadingButton(), title: Text('Your Account')),
        body: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Consumer<UserAccount?>(
                  builder: (context, value, child) {
                    if (value != null) {
                      return UserAvatar(
                          radius: 60,
                          avatarUrl: value.avatarUrl,
                          onPressed: () {
                            _chooseAvatar(context);
                          });
                    } else {
                      return UserAvatar(
                          radius: 60,
                          onPressed: () {
                            _chooseAvatar(context);
                          });
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        var result = await AuthService.signOut();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Logout'))
              ],
            )
          ],
        ));
  }
}
