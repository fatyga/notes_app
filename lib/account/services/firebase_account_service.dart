import 'package:cloud_firestore/cloud_firestore.dart';

import '../../authentication/authentication.dart';
import '../../service_locator.dart';
import '../account.dart';

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
