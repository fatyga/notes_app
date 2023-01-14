import 'package:get_it/get_it.dart';
import 'package:notes_app/authentication/business_logic/authentication_view_model.dart';
import 'package:notes_app/authentication/services/authentication_service.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());
  serviceLocator.registerLazySingleton(() => AuthenticationRepository());

  serviceLocator.registerFactory<AuthenticationViewModel>(
      () => AuthenticationViewModel());
}
