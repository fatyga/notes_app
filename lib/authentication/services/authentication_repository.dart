import 'package:notes_app/authentication/business_logic/models/app_user.dart';
import 'package:notes_app/service_locator.dart';

import 'authentication_service.dart';

class AuthenticationRepository {
  final AuthenticationService _auth = serviceLocator<AuthenticationService>();

  Stream<AppUser?> get authenticationChanges => _auth.authenticationChanges;

  Future<AppUser?> signIn(
      String email, String password, Function(String message) onError) async {
    return await _auth.signInUser(email, password, onError);
  }

  Future<AppUser?> register(
      String email, String password, Function(String message) onError) async {
    return await _auth.registerUser(email, password, onError);
  }

  Future<void> logOut() async {
    await _auth.signOutUser();
  }
}
