import 'package:get_it/get_it.dart';

import 'account/account.dart';
import 'authentication/authentication.dart';
import 'notes/notes.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // authentication
  serviceLocator.registerLazySingleton<AuthenticationService>(
      () => FirebaseAuthenticationService());
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  serviceLocator.registerFactory<SignInViewModel>(() => SignInViewModel());
  serviceLocator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  serviceLocator.registerFactory<SignOutViewModel>(() => SignOutViewModel());
  // notes
  serviceLocator
      .registerLazySingleton<NotesService>(() => FirestoreNotesService());

  serviceLocator
      .registerLazySingleton<NotesRepository>(() => NotesRepository());

  serviceLocator.registerFactoryParam<NotesListViewModel, List<Note>, void>(
      (initialNotes, _) => NotesListViewModel(initialNotes: initialNotes));

  serviceLocator
      .registerFactoryParam<NotesListWrapperViewModel, List<Note>, void>(
          (initialNotes, _) =>
              NotesListWrapperViewModel(initialNotes: initialNotes));

  serviceLocator
      .registerFactory<NotesPreviewViewModel>(() => NotesPreviewViewModel());
  serviceLocator
      .registerFactory<NoteUpdateViewModel>(() => NoteUpdateViewModel());
  serviceLocator.registerFactory<NewNoteViewModel>(() => NewNoteViewModel());
  serviceLocator
      .registerFactory<TagsManageViewModel>(() => TagsManageViewModel());
  // account
  serviceLocator
      .registerLazySingleton<AccountRepository>(() => AccountRepository());
  serviceLocator
      .registerLazySingleton<AccountService>(() => FirebaseAccountService());
  serviceLocator
      .registerLazySingleton<AvatarService>(() => FirebaseAvatarService());
  serviceLocator
      .registerFactory<UserAccountViewModel>(() => UserAccountViewModel());
  serviceLocator.registerFactory<AvatarViewModel>(() => AvatarViewModel());
  serviceLocator
      .registerFactory<NewAccountViewModel>(() => NewAccountViewModel());
  serviceLocator.registerFactory<UserAccountPreviewViewModel>(
      () => UserAccountPreviewViewModel());
  serviceLocator.registerFactory<UserAccountUpdateViewModel>(
      () => UserAccountUpdateViewModel());
}
