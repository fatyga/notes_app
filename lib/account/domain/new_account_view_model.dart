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

  Future<void> createAccount(String email, String password, String firstName,
      String lastName, File? avatar) async {
    setViewState(ViewState.busy);
    await _registerViewModel.registerUser(email, password);
    await _userAccountViewModel.addUserAccount(
        UserAccount(firstName: firstName, lastName: lastName), avatar);
    setViewState(ViewState.idle);
  }
}
