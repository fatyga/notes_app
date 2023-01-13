import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage storage;
  final String userUid;

  StorageService({required this.storage, required this.userUid});

  void updateAvatar(
      {required File file, required Function(TaskSnapshot) fn}) async {
    upload(
        file: file,
        path: 'avatar/$userUid/avatar.png',
        contentType: 'image/png',
        fn: fn);
  }

  void upload(
      {required String path,
      required File file,
      required String contentType,
      required Function(TaskSnapshot snap) fn}) async {
    final reference = storage.ref().child(path);

    reference
        .putFile(file, SettableMetadata(contentType: contentType))
        .snapshotEvents
        .listen(fn);
  }
}
