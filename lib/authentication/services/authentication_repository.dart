import 'package:notes_app/authentication/domain/models/app_user.dart';
import 'package:notes_app/service_locator.dart';

import 'authentication_service.dart';

class AuthenticationRepository {
  final AuthenticationService _auth = serviceLocator<AuthenticationService>();

  Stream<AppUser?> get authenticationChanges => _auth.authenticationChanges;

  Future<AppUser?> signIn(String email, String password) async {
    return await _auth.signInUser(email, password);
  }

  Future<AppUser?> register(String email, String password) async {
    return await _auth.registerUser(email, password);
  }

  Future<void> logOut() async {
    await _auth.signOutUser();
  }
}
