import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/authentication/business_logic/authentication_view_model.dart';
import 'package:notes_app/authentication/services/firebase_auth_service.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';
import 'package:notes_app/notes/domain/new_note_view_model.dart';
import 'package:notes_app/notes/domain/note_update_view_model.dart';
import 'package:notes_app/notes/domain/notes_list_view_model.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/notes/services/firestore_notes_service.dart';

import 'authentication/services/authentication_service.dart';
import 'notes/domain/note_preview_view_model.dart';
import 'notes/services/notes_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // authentication
  serviceLocator.registerLazySingleton<AuthenticationService>(
      () => FirebaseAuthenticationService());
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  serviceLocator.registerFactory<AuthenticationViewModel>(
      () => AuthenticationViewModel());

  // notes
  serviceLocator
      .registerLazySingleton<NotesService>(() => FirestoreNotesService());

  serviceLocator
      .registerLazySingleton<NotesRepository>(() => NotesRepository());

  serviceLocator
      .registerFactory<NotesListViewModel>(() => NotesListViewModel());
  serviceLocator
      .registerFactory<NotesPreviewViewModel>(() => NotesPreviewViewModel());
  serviceLocator
      .registerFactory<NoteUpdateViewModel>(() => NoteUpdateViewModel());
  serviceLocator.registerFactory<NewNoteViewModel>(() => NewNoteViewModel());
}
