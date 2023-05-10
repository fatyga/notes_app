import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../services/authentication_repository.dart';

class RegisterViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  Future<void> registerUser(
      String email, String password, Function(String) setError) async {
    setViewState(ViewState.busy);
    await _authRepo.register(email, password, setError);
    setViewState(ViewState.idle);
  }
}
