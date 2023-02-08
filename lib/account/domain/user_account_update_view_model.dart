import 'dart:async';
import 'dart:io';

import 'package:notes_app/account/services/account_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/userAccount.dart';

class UserAccountUpdateViewModel extends ViewModel {
  final AccountRepository _accountRepo = serviceLocator<AccountRepository>();

  Stream<UserAccount> get userAccountChanges => _accountRepo.userAccountChanges;

  late StreamSubscription accountChangesSubscription;

  late UserAccount _account;
  UserAccount get account => _account;

  File? _selectedAvatar;
  File? get selectedAvatar => _selectedAvatar;
  set selectedAvatar(File? avatar) {
    _selectedAvatar = avatar;
    notifyListeners();
  }

  void setError(String message) {
    setNotification(UserNotification(content: message, isError: true));
  }

  void startAccountChangesSubscription() {
    setViewState(ViewState.busy);
    accountChangesSubscription =
        _accountRepo.userAccountChanges.listen((account) {
      _account = account;
      if (status == ViewState.busy) {
        setViewState(ViewState.idle);
        return;
      }
      notifyListeners();
    });
  }

  void stopAccountChangesSubscription() {
    accountChangesSubscription.cancel();
  }

  Future<UserAccount> loadUserAccount() => _accountRepo.loadUserAccount();

  Future<void> updateUserAccount(
    UserAccount accountDetails,
  ) async {
    setViewState(ViewState.busy);
    await _accountRepo.updateUserAccount(
        accountDetails, _selectedAvatar, setError);
    if (userNotification.isError == true) {
      setViewState(
          ViewState.idle,
          const UserNotification(
              content: 'Failed to update account.', isError: true));
      return;
    }
    setViewState(ViewState.idle,
        const UserNotification(content: 'Account updated successfully.'));
  }
}
