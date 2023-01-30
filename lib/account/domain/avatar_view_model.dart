import 'dart:async';
import 'package:notes_app/account/services/account_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/view_model.dart';

class AvatarViewModel extends ViewModel {
  final AccountRepository _accountRepo = serviceLocator<AccountRepository>();

  late StreamSubscription avatarChangesSubscription;

  String _avatarUrl = '';
  String get avatarUrl => _avatarUrl;

  void startAvatarChangesSubscription() {
    avatarChangesSubscription =
        _accountRepo.userAccountChanges.listen((account) {
      _avatarUrl = account.avatarUrl;
      notifyListeners();
    });
  }

  void stopAvatarChangesSubscription() {
    avatarChangesSubscription.cancel();
  }
}
