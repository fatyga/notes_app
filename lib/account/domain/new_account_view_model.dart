import 'dart:io';

import 'package:notes_app/account/services/account_repository.dart';

import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/user_account.dart';

class NewAccountViewModel extends ViewModel {
  final AuthenticationRepository _authenticationRepo =
      serviceLocator<AuthenticationRepository>();
  final AccountRepository _accountRepo = serviceLocator<AccountRepository>();
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  File? _selectedAvatar;
  File? get selectedAvatar => _selectedAvatar;
  set selectedAvatar(File? avatar) {
    _selectedAvatar = avatar;
    notifyListeners();
  }

  Future<void> createAccount(
      String email, String password, String firstName, String lastName) async {
    setViewState(ViewState.busy);

    await _authenticationRepo.register(email, password, setError);
    if (userNotification.isError == true) {
      setViewState(
          ViewState.idle,
          userNotification.copyWith(
              content: 'Failed to register a user.', isError: true));
      return;
    }
    await _accountRepo.addUserAccount(
        UserAccount(firstName: firstName, lastName: lastName),
        _selectedAvatar,
        setError);
    if (userNotification.isError == true) {
      setViewState(
          ViewState.idle,
          const UserNotification(
              content: 'Failed to create account.', isError: true));
      return;
    }

    await _notesRepo.initializeTags(); // create defaulult tag
    setViewState(ViewState.idle,
        userNotification.copyWith(content: 'User created successfully.'));
  }
}
