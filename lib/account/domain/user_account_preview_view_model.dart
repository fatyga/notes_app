import 'dart:async';
import 'dart:io';

import 'package:notes_app/account/services/account_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/userAccount.dart';

class UserAccountPreviewViewModel extends ViewModel {
  final AccountRepository _accountRepo = serviceLocator<AccountRepository>();

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
