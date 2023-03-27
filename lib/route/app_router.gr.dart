// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:notes_app/account/screens/account_preview_screen.dart' as _i1;
import 'package:notes_app/account/screens/account_router.dart' as _i11;
import 'package:notes_app/account/screens/account_update_screen.dart' as _i2;
import 'package:notes_app/account/screens/home_router.dart' as _i12;
import 'package:notes_app/authentication/screens/authentication_router.dart'
    as _i14;
import 'package:notes_app/authentication/screens/register_screen.dart' as _i3;
import 'package:notes_app/authentication/screens/sign_in_screen.dart' as _i4;
import 'package:notes_app/notes/screens/new_note_page.dart' as _i5;
import 'package:notes_app/notes/screens/note_preview_page.dart' as _i7;
import 'package:notes_app/notes/screens/note_tags_manage.dart' as _i8;
import 'package:notes_app/notes/screens/notes_list_page.dart' as _i6;
import 'package:notes_app/notes/screens/notes_router.dart' as _i13;
import 'package:notes_app/notes/screens/update_note_page.dart' as _i9;
import 'package:notes_app/splash/splash_screen.dart' as _i10;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    UserAccountPreviewRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.UserAccountPreviewPage(),
      );
    },
    UserAccountUpdateRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.UserAccountUpdatePage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignInPage(),
      );
    },
    NewNoteRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.NewNotePage(),
      );
    },
    NoteListRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.NoteListPage(),
      );
    },
    NotePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<NotePreviewRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.NotePreviewPage(
          key: args.key,
          noteId: args.noteId,
        ),
      );
    },
    TagsManageRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.TagsManagePage(),
      );
    },
    UpdateNoteRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateNoteRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.UpdateNotePage(
          key: args.key,
          noteId: args.noteId,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SplashPage(),
      );
    },
    AccountRouter.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.AccountRouterPage(),
      );
    },
    HomeRouter.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.HomeRouterPage(),
      );
    },
    NotesRouter.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.NotesRouterPage(),
      );
    },
    AuthenticationRouter.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.AuthenticationRouterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.UserAccountPreviewPage]
class UserAccountPreviewRoute extends _i15.PageRouteInfo<void> {
  const UserAccountPreviewRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserAccountPreviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAccountPreviewRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.UserAccountUpdatePage]
class UserAccountUpdateRoute extends _i15.PageRouteInfo<void> {
  const UserAccountUpdateRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserAccountUpdateRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAccountUpdateRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignInPage]
class SignInRoute extends _i15.PageRouteInfo<void> {
  const SignInRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.NewNotePage]
class NewNoteRoute extends _i15.PageRouteInfo<void> {
  const NewNoteRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NewNoteRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewNoteRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.NoteListPage]
class NoteListRoute extends _i15.PageRouteInfo<void> {
  const NoteListRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NoteListRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoteListRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.NotePreviewPage]
class NotePreviewRoute extends _i15.PageRouteInfo<NotePreviewRouteArgs> {
  NotePreviewRoute({
    _i16.Key? key,
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

  static const _i15.PageInfo<NotePreviewRouteArgs> page =
      _i15.PageInfo<NotePreviewRouteArgs>(name);
}

class NotePreviewRouteArgs {
  const NotePreviewRouteArgs({
    this.key,
    required this.noteId,
  });

  final _i16.Key? key;

  final String noteId;

  @override
  String toString() {
    return 'NotePreviewRouteArgs{key: $key, noteId: $noteId}';
  }
}

/// generated route for
/// [_i8.TagsManagePage]
class TagsManageRoute extends _i15.PageRouteInfo<void> {
  const TagsManageRoute({List<_i15.PageRouteInfo>? children})
      : super(
          TagsManageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TagsManageRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.UpdateNotePage]
class UpdateNoteRoute extends _i15.PageRouteInfo<UpdateNoteRouteArgs> {
  UpdateNoteRoute({
    _i16.Key? key,
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

  static const _i15.PageInfo<UpdateNoteRouteArgs> page =
      _i15.PageInfo<UpdateNoteRouteArgs>(name);
}

class UpdateNoteRouteArgs {
  const UpdateNoteRouteArgs({
    this.key,
    required this.noteId,
  });

  final _i16.Key? key;

  final String noteId;

  @override
  String toString() {
    return 'UpdateNoteRouteArgs{key: $key, noteId: $noteId}';
  }
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

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.AccountRouterPage]
class AccountRouter extends _i15.PageRouteInfo<void> {
  const AccountRouter({List<_i15.PageRouteInfo>? children})
      : super(
          AccountRouter.name,
          initialChildren: children,
        );

  static const String name = 'AccountRouter';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.HomeRouterPage]
class HomeRouter extends _i15.PageRouteInfo<void> {
  const HomeRouter({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouter';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.NotesRouterPage]
class NotesRouter extends _i15.PageRouteInfo<void> {
  const NotesRouter({List<_i15.PageRouteInfo>? children})
      : super(
          NotesRouter.name,
          initialChildren: children,
        );

  static const String name = 'NotesRouter';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.AuthenticationRouterPage]
class AuthenticationRouter extends _i15.PageRouteInfo<void> {
  const AuthenticationRouter({List<_i15.PageRouteInfo>? children})
      : super(
          AuthenticationRouter.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRouter';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
