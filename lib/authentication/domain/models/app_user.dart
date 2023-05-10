import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;

  AppUser({required this.uid});

  factory AppUser.fromFirebase(User firebaseUser) {
    return AppUser(uid: firebaseUser.uid);
  }
}
