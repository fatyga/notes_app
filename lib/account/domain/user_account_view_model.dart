import 'dart:io';

import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../account.dart';

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
