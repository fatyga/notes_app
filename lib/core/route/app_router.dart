import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/authenticate/authenticate_top_page.dart';
import 'package:notes_app/pages/authenticate/register_page.dart';
import 'package:notes_app/pages/authenticate/sign_in_page.dart';
import 'package:notes_app/pages/home/note_list_page.dart';
import 'package:notes_app/pages/home/home_top_page.dart';
import 'package:notes_app/pages/home/note_manipulation_page.dart';
import 'package:notes_app/pages/home/note_preview_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(
      path: '/authentication',
      page: AuthenticateTopPage,
      initial: true,
      children: [
        AutoRoute(path: 'signIn', initial: true, page: SignInPage),
        AutoRoute(path: 'register', page: RegisterPage)
      ]),
  AutoRoute(path: '/home', page: HomeTopPage, children: [
    AutoRoute(path: 'noteList', initial: true, page: NoteListPage),
    AutoRoute(path: 'notePreview', page: NotePreviewPage),
    AutoRoute(path: 'noteManipulation', page: NoteManipulationPage)
  ])
])
class $AppRouter {}
