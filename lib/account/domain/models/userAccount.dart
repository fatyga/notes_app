import 'package:firebase_auth/firebase_auth.dart';

class UserAccount {
  String firstName;
  String lastName;
  String avatarUrl;

  UserAccount(
      {required this.firstName, required this.lastName, this.avatarUrl = ''});

  UserAccount copyWith(
      {String? firstName, String? lastName, String? avatarUrl}) {
    return UserAccount(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatarUrl: avatarUrl ?? this.avatarUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'avatarUrl': avatarUrl
    };
  }
}
