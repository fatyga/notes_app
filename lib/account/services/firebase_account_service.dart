import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/account/domain/models/user_account.dart';
import 'package:notes_app/account/services/account_service.dart';
import 'package:notes_app/authentication/services/authentication_service.dart';
import 'package:notes_app/service_locator.dart';

class FirebaseAccountService implements AccountService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();

  @override
  Stream<UserAccount> get userAccountChanges => _firestore
      .collection('accounts')
      .doc(_authenticationService.getCurrentUser()!.uid)
      .snapshots()
      .map((firestoreAccount) => UserAccount(
          firstName: firestoreAccount.get('firstName'),
          lastName: firestoreAccount.get('lastName'),
          avatarUrl: firestoreAccount.get('avatarUrl')));

  @override
  Future<UserAccount> loadUserAccount() async {
    final userAccount = await _firestore
        .collection('accounts')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .get();
    return UserAccount(
        firstName: userAccount.get('firstName'),
        lastName: userAccount.get('lastName'));
  }

  @override
  Future<void> addUserAccount(Map<String, dynamic> accountDetails) async {
    await _firestore
        .collection('accounts')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .set(accountDetails);
  }

  @override
  Future<void> updateUserAccount(Map<String, dynamic> accountDetails) async {
    await _firestore
        .collection('accounts')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .update(accountDetails);
  }
}
