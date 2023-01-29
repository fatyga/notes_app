import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:notes_app/account/services/avatar_service.dart';
import 'package:notes_app/authentication/services/authentication_service.dart';
import 'package:notes_app/service_locator.dart';

class FirebaseAvatarService implements AvatarService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();

  @override
  Future<String> uploadAvatar(File file, Function(String) onError) async {
    try {
      final reference = _storage.ref().child(
          'avatar/${_authenticationService.getCurrentUser()!.uid}/avatar.png');
      final uploadTask = await reference.putFile(
          file, SettableMetadata(contentType: 'image/png'));
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      onError(e.message!);
    }
    throw 'Error';
  }
}
