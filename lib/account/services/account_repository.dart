import 'dart:io';

import 'package:notes_app/account/domain/models/userAccount.dart';
import 'package:notes_app/account/services/account_service.dart';
import 'package:notes_app/account/services/avatar_service.dart';
import 'package:notes_app/service_locator.dart';

class AccountRepository {
  final AccountService _accountService = serviceLocator<AccountService>();
  final AvatarService _avatarService = serviceLocator<AvatarService>();

  Stream<UserAccount> get userAccountChanges =>
      _accountService.userAccountChanges;

  Future<UserAccount> loadUserAccount() => _accountService.loadUserAccount();

  Future<void> addUserAccount(
      UserAccount newAccount, File? avatar, Function(String) onError) async {
    await _accountService.addUserAccount(newAccount.toMap());
    if (avatar != null) {
      String newAvatarUrl = await _avatarService.uploadAvatar(avatar, onError);
      newAccount = newAccount.copyWith(avatarUrl: newAvatarUrl);
      await _accountService.updateUserAccount(newAccount.toMap());
    }
  }

  Future<void> updateUserAccount(UserAccount updatedAccount, File? avatar,
      Function(String) onError) async {
    await _accountService.updateUserAccount(updatedAccount.toMap());
    if (avatar != null) {
      String newAvatarUrl = await _avatarService.uploadAvatar(avatar, onError);
      updatedAccount = updatedAccount.copyWith(avatarUrl: newAvatarUrl);
      await _accountService.updateUserAccount(updatedAccount.toMap());
    }
  }
}
