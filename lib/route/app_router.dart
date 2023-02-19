import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/account/screens/account_preview_screen.dart';
import 'package:notes_app/account/screens/account_update_screen.dart';
import 'package:notes_app/account/screens/account_wrapper.dart';
import 'package:notes_app/authentication/screens/wrapper_page.dart';
import 'package:notes_app/authentication/screens/register_screen.dart';
import 'package:notes_app/authentication/screens/sign_in_screen.dart';
import 'package:notes_app/notes/screens/new_note_page.dart';
import 'package:notes_app/notes/screens/note_tags_manage.dart';
import 'package:notes_app/notes/screens/notes_list_page.dart';
import 'package:notes_app/notes/screens/notes_wrapper_page.dart';
import 'package:notes_app/notes/screens/update_note_page.dart';
import 'package:notes_app/notes/screens/note_preview_page.dart';

import '../account/screens/wrapper.dart';

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
      AutoRoute(path: 'newNote', page: NewNotePage),
      AutoRoute(path: 'updateNote', page: UpdateNotePage),
      AutoRoute(path: 'tagsManager', page: TagsManagePage)
    ]),
    AutoRoute(path: 'userAccount', page: UserAccountWrapperPage, children: [
      AutoRoute(path: 'preview', initial: true, page: UserAccountPreviewPage),
      AutoRoute(path: 'update', page: UserAccountUpdatePage)
    ])
  ]),
])
class $AppRouter {}
