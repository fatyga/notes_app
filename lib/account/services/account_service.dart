import 'package:notes_app/account/domain/models/userAccount.dart';

abstract class AccountService {
  Stream<UserAccount> get userAccountChanges;
  Future<UserAccount> loadUserAccount();
  Future<void> addUserAccount(Map<String, dynamic> accountDetails);
  Future<void> updateUserAccount(Map<String, dynamic> accountDetails);
}
