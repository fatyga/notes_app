import '../domain/models/app_user.dart';

abstract class AuthenticationService {
  AppUser? getCurrentUser();
  Stream<AppUser?> get authenticationChanges;
  Future<AppUser?> signInUser(String email, String password);
  Future<void> signOutUser();
  Future<AppUser?> registerUser(String email, String password);
}
