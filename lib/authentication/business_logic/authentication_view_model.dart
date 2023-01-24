import 'package:flutter/material.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/app_user.dart';

class AuthenticationViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  AppUser? _user;
  String? _error;

  AppUser? get user => _user;
  String? get error => _error;

  void setError(String? message) {
    _error = message;
  }

  Future<void> signInUser(String email, String password) async {
    setError(null);
    setViewState(ViewState.busy);
    _user = await _authRepo.signIn(email, password, setError);
    setViewState(ViewState.idle);
  }

  Future<void> registerUser(String email, String password) async {
    setError(null);
    setViewState(ViewState.busy);
    _user = await _authRepo.register(email, password, setError);
    setViewState(ViewState.idle);
  }

  Future<void> logOutUser() async {
    setError(null);
    setViewState(ViewState.busy);
    await _authRepo.logOut();
    setViewState(ViewState.idle);
  }
}
