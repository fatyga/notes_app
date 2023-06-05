import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../services/authentication_repository.dart';

class SignOutViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  Future<void> signOutUser() async {
    setViewState(ViewState.busy);

    try {
      await _authRepo.logOut();
    } catch (e) {
      setViewState(ViewState.idle);
      rethrow;
    }
    setViewState(
      ViewState.idle,
    );
  }
}
