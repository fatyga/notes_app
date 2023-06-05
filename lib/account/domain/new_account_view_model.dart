import 'dart:io';

import '../../authentication/authentication.dart';
import '../../notes/notes.dart';
import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../account.dart';

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

    try {
      await _authenticationRepo.register(email, password);

      await _accountRepo.addUserAccount(
          UserAccount(firstName: firstName, lastName: lastName),
          _selectedAvatar);

      await _notesRepo.initializeTags(); // create defaulult tag

      setViewState(
        ViewState.idle,
      );
    } catch (e) {
      rethrow;
    }
  }
}
