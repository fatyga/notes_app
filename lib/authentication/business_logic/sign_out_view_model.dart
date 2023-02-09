import 'package:flutter/material.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/app_user.dart';

class SignOutViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  Future<void> signOutUser() async {
    setViewState(ViewState.busy);
    await _authRepo.logOut();
    setViewState(ViewState.idle,
        userNotification.copyWith(content: 'User successfuly is logged out.'));
  }
}
