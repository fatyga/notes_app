import 'package:flutter/material.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/app_user.dart';

class RegisterViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  Future<void> registerUser(
      String email, String password, Function(String?) setError) async {
    setError(null);
    setViewState(ViewState.busy);
    await _authRepo.register(email, password, setError);
    setViewState(ViewState.idle);
  }
}
