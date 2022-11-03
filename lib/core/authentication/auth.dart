import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/core/database/firestore_service.dart';

class AppUser {
  final String uid;

  AppUser({required this.uid});
}

class AuthService {
  AppUser? userFromFirebase(User? user) {
    return user == null ? null : AppUser(uid: user.uid);
  }

  Stream<AppUser?> get user =>
      FirebaseAuth.instance.authStateChanges().map(userFromFirebase);

  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password, Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userFromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      }
    }
  }

  Future<AppUser?> registerWithEmailAndPassword(
      String email, String password, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userFromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      }
    }
  }

  Future signOut() async {
    try {
      final credential = await FirebaseAuth.instance.signOut();
      return credential;
    } catch (e) {
      print(e.toString());
    }
  }
}
