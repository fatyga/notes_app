import 'package:flutter/material.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/app_user.dart';

class SignInViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  void setError(String message) {
    setNotification(UserNotification(content: message, isError: true));
  }

  Future<void> signInUser(String email, String password) async {
    setViewState(ViewState.busy);
    await _authRepo.signIn(email, password, setError);
    setViewState(ViewState.idle);
  }
}
