// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i17;
import 'package:notes_app/account/screens/account_preview_screen.dart' as _i13;
import 'package:notes_app/account/screens/account_router.dart' as _i1;
import 'package:notes_app/account/screens/account_update_screen.dart' as _i14;
import 'package:notes_app/account/screens/home_router.dart' as _i3;
import 'package:notes_app/authentication/screens/authentication_router.dart'
    as _i2;
import 'package:notes_app/authentication/screens/register_screen.dart' as _i8;
import 'package:notes_app/authentication/screens/sign_in_screen.dart' as _i9;
import 'package:notes_app/notes/notes.dart' as _i16;
import 'package:notes_app/notes/screens/new_note_page.dart' as _i4;
import 'package:notes_app/notes/screens/note_preview_page.dart' as _i6;
import 'package:notes_app/notes/screens/note_tags_manage_page.dart' as _i11;
import 'package:notes_app/notes/screens/notes_list_page.dart' as _i5;
import 'package:notes_app/notes/screens/notes_router.dart' as _i7;
import 'package:notes_app/notes/screens/update_note_page.dart' as _i12;
import 'package:notes_app/splash/splash_screen.dart' as _i10;

/// generated route for
/// [_i1.AccountRouterPage]
class AccountRouter extends _i15.PageRouteInfo<void> {
  const AccountRouter({List<_i15.PageRouteInfo>? children})
      : super(
          AccountRouter.name,
          initialChildren: children,
        );

  static const String name = 'AccountRouter';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountRouterPage();
    },
  );
}

/// generated route for
/// [_i2.AuthenticationRoute]
class AuthenticationRoute extends _i15.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthenticationRoute();
    },
  );
}

/// generated route for
/// [_i3.HomeRouterPage]
class HomeRouter extends _i15.PageRouteInfo<void> {
  const HomeRouter({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouter';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeRouterPage();
    },
  );
}

/// generated route for
/// [_i4.NewNotePage]
class NewNoteRoute extends _i15.PageRouteInfo<void> {
  const NewNoteRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NewNoteRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewNoteRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.NewNotePage();
    },
  );
}

/// generated route for
/// [_i5.NoteListPage]
class NoteListRoute extends _i15.PageRouteInfo<NoteListRouteArgs> {
  NoteListRoute({
    required List<_i16.Note> notesFromInitialFetch,
    _i17.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          NoteListRoute.name,
          args: NoteListRouteArgs(
            notesFromInitialFetch: notesFromInitialFetch,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'NoteListRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NoteListRouteArgs>();
      return _i5.NoteListPage(
        notesFromInitialFetch: args.notesFromInitialFetch,
        key: args.key,
      );
    },
  );
}

class NoteListRouteArgs {
  const NoteListRouteArgs({
    required this.notesFromInitialFetch,
    this.key,
  });

  final List<_i16.Note> notesFromInitialFetch;

  final _i17.Key? key;

  @override
  String toString() {
    return 'NoteListRouteArgs{notesFromInitialFetch: $notesFromInitialFetch, key: $key}';
  }
}

/// generated route for
/// [_i6.NotePreviewPage]
class NotePreviewRoute extends _i15.PageRouteInfo<NotePreviewRouteArgs> {
  NotePreviewRoute({
    _i17.Key? key,
    required String noteId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          NotePreviewRoute.name,
          args: NotePreviewRouteArgs(
            key: key,
            noteId: noteId,
          ),
          initialChildren: children,
        );

  static const String name = 'NotePreviewRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotePreviewRouteArgs>();
      return _i6.NotePreviewPage(
        key: args.key,
        noteId: args.noteId,
      );
    },
  );
}

class NotePreviewRouteArgs {
  const NotePreviewRouteArgs({
    this.key,
    required this.noteId,
  });

  final _i17.Key? key;

  final String noteId;

  @override
  String toString() {
    return 'NotePreviewRouteArgs{key: $key, noteId: $noteId}';
  }
}

/// generated route for
/// [_i7.NotesRouterPage]
class NotesRouter extends _i15.PageRouteInfo<void> {
  const NotesRouter({List<_i15.PageRouteInfo>? children})
      : super(
          NotesRouter.name,
          initialChildren: children,
        );

  static const String name = 'NotesRouter';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.NotesRouterPage();
    },
  );
}

/// generated route for
/// [_i8.RegisterPage]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.RegisterPage();
    },
  );
}

/// generated route for
/// [_i9.SignInPage]
class SignInRoute extends _i15.PageRouteInfo<void> {
  const SignInRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i9.SignInPage();
    },
  );
}

/// generated route for
/// [_i10.SplashPage]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.SplashPage();
    },
  );
}

/// generated route for
/// [_i11.TagsManagePage]
class TagsManageRoute extends _i15.PageRouteInfo<void> {
  const TagsManageRoute({List<_i15.PageRouteInfo>? children})
      : super(
          TagsManageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TagsManageRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.TagsManagePage();
    },
  );
}

/// generated route for
/// [_i12.UpdateNotePage]
class UpdateNoteRoute extends _i15.PageRouteInfo<UpdateNoteRouteArgs> {
  UpdateNoteRoute({
    _i17.Key? key,
    required String noteId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          UpdateNoteRoute.name,
          args: UpdateNoteRouteArgs(
            key: key,
            noteId: noteId,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateNoteRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UpdateNoteRouteArgs>();
      return _i12.UpdateNotePage(
        key: args.key,
        noteId: args.noteId,
      );
    },
  );
}

class UpdateNoteRouteArgs {
  const UpdateNoteRouteArgs({
    this.key,
    required this.noteId,
  });

  final _i17.Key? key;

  final String noteId;

  @override
  String toString() {
    return 'UpdateNoteRouteArgs{key: $key, noteId: $noteId}';
  }
}

/// generated route for
/// [_i13.UserAccountPreviewPage]
class UserAccountPreviewRoute extends _i15.PageRouteInfo<void> {
  const UserAccountPreviewRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserAccountPreviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAccountPreviewRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.UserAccountPreviewPage();
    },
  );
}

/// generated route for
/// [_i14.UserAccountUpdatePage]
class UserAccountUpdateRoute extends _i15.PageRouteInfo<void> {
  const UserAccountUpdateRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserAccountUpdateRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAccountUpdateRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.UserAccountUpdatePage();
    },
  );
}
