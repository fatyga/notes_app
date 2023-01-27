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

  Future<void> addUserAccount(UserAccount newAccount, File? avatar) async {
    if (avatar != null) {
      String newAvatarUrl = await _avatarService.uploadAvatar(avatar);
      newAccount.copyWith(avatarUrl: newAvatarUrl);
    }
    await _accountService.addUserAccount(newAccount.toMap());
  }

  Future<void> updateUserAccount(UserAccount newAccount, File? avatar) async {
    if (avatar != null) {
      String newAvatarUrl = await _avatarService.uploadAvatar(avatar);
      newAccount.copyWith(avatarUrl: newAvatarUrl);
    }
    await _accountService.updateUserAccount(newAccount.toMap());
  }
}
