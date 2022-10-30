import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  void updateAvatar(
      {required String uid,
      required File file,
      required Function(TaskSnapshot) fn}) async {
    upload(
        file: file,
        path: 'avatar/$uid/avatar.png',
        contentType: 'image/png',
        fn: fn);
  }

  void upload(
      {required String path,
      required File file,
      required String contentType,
      required Function(TaskSnapshot snap) fn}) async {
    final reference = FirebaseStorage.instance.ref().child(path);

    reference
        .putFile(file, SettableMetadata(contentType: contentType))
        .snapshotEvents
        .listen(fn);
  }
}
