import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/authentication/domain/models/app_user.dart';

import 'authentication_service.dart';

class FirebaseAuthenticationService implements AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  AppUser? getCurrentUser() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      return AppUser(uid: currentUser.uid);
    }
    return null;
  }

  @override
  Stream<AppUser?> get authenticationChanges =>
      _auth.authStateChanges().map((user) {
        if (user != null) {
          return AppUser.fromFirebase(user);
        }
        return null;
      });

  @override
  Future<AppUser?> signInUser(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        return AppUser.fromFirebase(credential.user!);
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
    return null;
  }

  @override
  Future<AppUser?> registerUser(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        return AppUser.fromFirebase(credential.user!);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    }
    return null;
  }

  @override
  Future<void> signOutUser() async {
    final credential = await FirebaseAuth.instance.signOut();
    return credential;
  }
}
