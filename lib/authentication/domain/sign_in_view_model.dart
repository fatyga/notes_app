import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../services/authentication_repository.dart';

class SignInViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  Future<void> signInUser(String email, String password) async {
    setViewState(ViewState.busy);
    await _authRepo.signIn(email, password, setError);
    setViewState(ViewState.idle);
  }
}
