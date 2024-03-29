import 'dart:async';
import 'dart:io';

import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../account.dart';

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
    await _accountRepo.updateUserAccount(accountDetails, _selectedAvatar);
    setViewState(
      ViewState.idle,
    );
  }
}
