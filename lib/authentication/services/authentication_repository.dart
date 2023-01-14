import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/authentication/business_logic/models/app_user.dart';
import 'package:notes_app/authentication/services/authentication_service.dart';
import 'package:notes_app/service_locator.dart';

class AuthenticationRepository {
  final AuthService _auth = serviceLocator<AuthService>();

  Future<AppUser?> signIn(
      String email, String password, Function(String message) onError) async {
    User? user =
        await _auth.signInWithEmailAndPassword(email, password, onError);
    if (user != null) {
      return AppUser.fromFirebase(user);
    }
    return null;
  }

  Future<AppUser?> register(
      String email, String password, Function(String message) onError) async {
    User? user =
        await _auth.registerWithEmailAndPassword(email, password, onError);
    if (user != null) {
      return AppUser.fromFirebase(user);
    }
    return null;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
