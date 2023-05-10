import 'dart:async';

import '../../service_locator.dart';
import '../../shared/view_model.dart';
import '../account.dart';

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
