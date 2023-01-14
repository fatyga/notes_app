import 'package:flutter/material.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/service_locator.dart';

import 'models/app_user.dart';

enum ModelStatus { idle, busy }

class AuthenticationViewModel extends ChangeNotifier {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  ModelStatus _status = ModelStatus.idle;
  AppUser? _user;
  String? _error;

  ModelStatus get status => _status;
  AppUser? get user => _user;
  String? get error => _error;

  void setError(String? message) {
    _error = message;
  }

  void setModelStatus(ModelStatus status) {
    _status = status;
    notifyListeners();
  }

  Future<void> signInUser(String email, String password) async {
    setError(null);
    setModelStatus(ModelStatus.busy);
    _user = await _authRepo.signIn(email, password, setError);
    setModelStatus(ModelStatus.idle);
  }

  Future<void> registerUser(String email, String password) async {
    setError(null);
    setModelStatus(ModelStatus.busy);
    _user = await _authRepo.register(email, password, setError);
    setModelStatus(ModelStatus.idle);
  }

  Future<void> logOutUser() async {
    setError(null);
    setModelStatus(ModelStatus.busy);
    await _authRepo.logOut();
    setModelStatus(ModelStatus.idle);
  }
}
