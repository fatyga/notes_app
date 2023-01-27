import 'dart:io';

abstract class AvatarService {
  Future<String> uploadAvatar(File file);
}
