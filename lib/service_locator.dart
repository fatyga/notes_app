import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/authentication/business_logic/authentication_view_model.dart';
import 'package:notes_app/authentication/services/authentication_service.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/notes/domain/notes_view_model.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/notes/services/notes_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // authentication
  serviceLocator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  serviceLocator.registerFactory<AuthenticationViewModel>(
      () => AuthenticationViewModel());

  //firestore
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // notes
  serviceLocator.registerLazySingleton<NotesService>(() => NotesService());
  serviceLocator.registerLazySingleton<NotesViewModel>(() => NotesViewModel());
  serviceLocator
      .registerLazySingleton<NotesRepository>(() => NotesRepository());
}
