import 'dart:async';

import '../../authentication/authentication.dart';
import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../account.dart';

class UserAccountPreviewViewModel extends ViewModel {
  final AccountRepository _accountRepo = serviceLocator<AccountRepository>();
  final SignOutViewModel _logOutModel = serviceLocator<SignOutViewModel>();

  Future<void> signOutUser() => _logOutModel.signOutUser();
  Stream<UserAccount> get userAccountChanges => _accountRepo.userAccountChanges;

  late StreamSubscription accountChangesSubscription;

  late UserAccount _account;
  UserAccount get account => _account;

  void startAccountChangesSubscription() {
    setViewState(ViewState.busy);
    accountChangesSubscription =
        _accountRepo.userAccountChanges.listen((account) {
      _account = account;
      if (status == ViewState.busy) {
        setViewState(ViewState.idle);
        return;
      } else {
        notifyListeners();
      }
    });
  }

  void stopAccountChangesSubscription() {
    accountChangesSubscription.cancel();
  }
}
