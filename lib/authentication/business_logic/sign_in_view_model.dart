import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

class SignInViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  Future<void> signInUser(String email, String password) async {
    setViewState(ViewState.busy);
    await _authRepo.signIn(email, password, setError);
    setViewState(ViewState.idle);
  }
}
