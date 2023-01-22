import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/authentication/business_logic/models/app_user.dart';

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
  Future<AppUser?> signInUser(
      String email, String password, Function(String message) onError) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        return AppUser.fromFirebase(credential.user!);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      }
    }
    return null;
  }

  @override
  Future<AppUser?> registerUser(
      String email, String password, Function onError) async {
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
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      }
    }
    return null;
  }

  @override
  Future<void> signOutUser() async {
    try {
      final credential = await FirebaseAuth.instance.signOut();
      return credential;
    } catch (e) {}
  }
}
