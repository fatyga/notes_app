import 'dart:io';

import 'package:notes_app/account/services/account_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/userAccount.dart';

class UserAccountViewModel extends ViewModel {
  final AccountRepository _accountRepo = serviceLocator<AccountRepository>();

  Stream<UserAccount> get userAccountChanges => _accountRepo.userAccountChanges;

  Future<void> addUserAccount(UserAccount accountDetails, File? avatar,
      Function(String) onError) async {
    setViewState(ViewState.busy);
    await _accountRepo.addUserAccount(accountDetails, avatar, onError);
    setViewState(ViewState.idle);
  }

  Future<void> updateUserAccount(UserAccount accountDetails, File? avatar,
      Function(String) onError) async {
    setViewState(ViewState.busy);
    await _accountRepo.addUserAccount(accountDetails, avatar, onError);
    setViewState(ViewState.idle);
  }
}
