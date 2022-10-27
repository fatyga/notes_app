import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<String> updateAvatar({required String uid, required File file}) async {
    return await upload(
        file: file, path: 'avatar/$uid/avatar.png', contentType: 'image/png');
  }

  Future<String> upload(
      {required String path,
      required File file,
      required String contentType}) async {
    final reference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = await reference.putFile(
        file, SettableMetadata(contentType: contentType));
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }
}
