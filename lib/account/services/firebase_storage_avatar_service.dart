import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../authentication/authentication.dart';
import '../../service_locator.dart';
import 'avatar_service.dart';

class FirebaseAvatarService implements AvatarService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();

  @override
  Future<String> uploadAvatar(File file) async {
    try {
      final reference = _storage.ref().child(
          'avatar/${_authenticationService.getCurrentUser()!.uid}/avatar.png');
      final uploadTask = await reference.putFile(
          file, SettableMetadata(contentType: 'image/png'));
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Unknown error');
    }
  }
}
