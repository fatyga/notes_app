import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/authenticate/register_page.dart';
import 'package:notes_app/pages/authenticate/sign_in_page.dart';
import 'package:notes_app/pages/home/home_page.dart';
import 'package:notes_app/pages/home/note_manipulation_page.dart';
import 'package:notes_app/pages/home/note_preview_page.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SignInPage, initial: true),
  AutoRoute(page: RegisterPage),
  AutoRoute(page: HomePage),
  AutoRoute(page: NoteManipulationPage),
  AutoRoute(page: NotePreviewPage)
])
class $AppRouter {}
