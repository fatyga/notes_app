import '../business_logic/models/app_user.dart';

abstract class AuthenticationService {
  Stream<AppUser?> get authenticationChanges;
  Future<AppUser?> signInUser(
      String email, String password, Function(String message) onError);
  Future<void> signOutUser();
  Future<AppUser?> registerUser(
      String email, String password, Function(String message) onError);
}
