import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/authentication/authentication_wrapper_page.dart';
import 'package:notes_app/pages/authentication/register_page.dart';
import 'package:notes_app/pages/authentication/sign_in_page.dart';
import 'package:notes_app/pages/home/notes/note_list_page.dart';
import 'package:notes_app/pages/home/notes/notes_wrapper_page.dart';
import 'package:notes_app/pages/home/notes/note_manipulation_page.dart';
import 'package:notes_app/pages/home/notes/note_preview_page.dart';
import 'package:notes_app/pages/home/wrapper.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(
      path: '/authentication',
      page: AuthenticationWrapperPage,
      children: [
        AutoRoute(path: 'signIn', initial: true, page: SignInPage),
        AutoRoute(path: 'register', page: RegisterPage)
      ]),
  AutoRoute(path: '/', page: HomePage, children: [
    AutoRoute(path: 'notes', initial: true, page: NotesWrapperPage, children: [
      AutoRoute(path: 'noteList', initial: true, page: NoteListPage),
      AutoRoute(path: 'notePreview', page: NotePreviewPage),
      AutoRoute(path: 'noteManipulation', page: NoteManipulationPage)
    ]),
  ]),
])
class $AppRouter {}
