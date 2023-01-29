import 'dart:io';

import 'package:notes_app/account/domain/user_account_view_model.dart';
import 'package:notes_app/authentication/business_logic/register_view_model.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/userAccount.dart';

class NewAccountViewModel extends ViewModel {
  final RegisterViewModel _registerViewModel =
      serviceLocator<RegisterViewModel>();
  final UserAccountViewModel _userAccountViewModel =
      serviceLocator<UserAccountViewModel>();

  File? _selectedAvatar;
  File? get selectedAvatar => _selectedAvatar;
  set selectedAvatar(File? avatar) {
    _selectedAvatar = avatar;
    notifyListeners();
  }

  String? _error;

  String? get error => _error;

  void setError(String? message) {
    _error = message;
  }

  Future<void> createAccount(
      String email, String password, String firstName, String lastName) async {
    setViewState(ViewState.busy);
    setError(null);
    await _registerViewModel.registerUser(email, password, setError);
    if (error != null) {
      setViewState(ViewState.idle);
      return;
    }
    await _userAccountViewModel.addUserAccount(
        UserAccount(firstName: firstName, lastName: lastName),
        _selectedAvatar,
        setError);
    if (error != null) {
      setViewState(ViewState.idle);
      return;
    }
    setViewState(ViewState.idle);
  }
}
