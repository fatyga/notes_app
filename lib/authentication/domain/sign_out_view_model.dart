import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../services/authentication_repository.dart';

class SignOutViewModel extends ViewModel {
  final AuthenticationRepository _authRepo =
      serviceLocator<AuthenticationRepository>();

  Future<void> signOutUser() async {
    setViewState(ViewState.busy);
    await _authRepo.logOut();
    setViewState(ViewState.idle,
        userNotification.copyWith(content: 'User successfuly is logged out.'));
  }
}
