import 'dart:io';

import '../../service_locator.dart';
import '../account.dart';

class AccountRepository {
  final AccountService _accountService = serviceLocator<AccountService>();
  final AvatarService _avatarService = serviceLocator<AvatarService>();

  Stream<UserAccount> get userAccountChanges =>
      _accountService.userAccountChanges;

  Future<UserAccount> loadUserAccount() => _accountService.loadUserAccount();

  Future<void> addUserAccount(
    UserAccount newAccount,
    File? avatar,
  ) async {
    await _accountService.addUserAccount(newAccount.toMap());
    if (avatar != null) {
      String newAvatarUrl = await _avatarService.uploadAvatar(avatar);
      newAccount = newAccount.copyWith(avatarUrl: newAvatarUrl);
      await _accountService.updateUserAccount(newAccount.toMap());
    }
  }

  Future<void> updateUserAccount(
    UserAccount updatedAccount,
    File? avatar,
  ) async {
    await _accountService.updateUserAccount(updatedAccount.toMap());
    if (avatar != null) {
      String newAvatarUrl = await _avatarService.uploadAvatar(avatar);
      updatedAccount = updatedAccount.copyWith(avatarUrl: newAvatarUrl);
      await _accountService.updateUserAccount(updatedAccount.toMap());
    }
  }
}
