import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../services/authentication_repository.dart';

class RegisterViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  Future<void> registerUser(String email, String password) async {
    setViewState(ViewState.busy);
    try {
      await _authRepo.register(email, password);
    } catch (e) {
      setViewState(ViewState.idle);
      rethrow;
    }
    setViewState(ViewState.idle);
  }
}
