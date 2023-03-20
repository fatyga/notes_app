// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;

import '../account/screens/account_preview_screen.dart' as _i13;
import '../account/screens/account_update_screen.dart' as _i14;
import '../account/screens/account_wrapper.dart' as _i7;
import '../account/screens/wrapper.dart' as _i3;
import '../authentication/screens/register_screen.dart' as _i5;
import '../authentication/screens/sign_in_screen.dart' as _i4;
import '../authentication/screens/wrapper_page.dart' as _i2;
import '../notes/screens/new_note_page.dart' as _i10;
import '../notes/screens/note_preview_page.dart' as _i9;
import '../notes/screens/note_tags_manage.dart' as _i12;
import '../notes/screens/notes_list_page.dart' as _i8;
import '../notes/screens/notes_wrapper_page.dart' as _i6;
import '../notes/screens/update_note_page.dart' as _i11;
import '../splash/splash_screen.dart' as _i1;

class AppRouter extends _i15.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    AuthenticationWrapperRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AuthenticationWrapperPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SignInPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.RegisterPage(),
      );
    },
    NotesWrapperRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.NotesWrapperPage(),
      );
    },
    UserAccountWrapperRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.UserAccountWrapperPage(),
      );
    },
    NoteListRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.NoteListPage(),
      );
    },
    NotePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<NotePreviewRouteArgs>();
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.NotePreviewPage(
          key: args.key,
          noteId: args.noteId,
        ),
      );
    },
    NewNoteRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.NewNotePage(),
      );
    },
    UpdateNoteRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateNoteRouteArgs>();
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.UpdateNotePage(
          key: args.key,
          noteId: args.noteId,
        ),
      );
    },
    TagsManageRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.TagsManagePage(),
      );
    },
    UserAccountPreviewRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.UserAccountPreviewPage(),
      );
    },
    UserAccountUpdateRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.UserAccountUpdatePage(),
      );
    },
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i15.RouteConfig(
          AuthenticationWrapperRoute.name,
          path: '/authentication',
          children: [
            _i15.RouteConfig(
              '#redirect',
              path: '',
              parent: AuthenticationWrapperRoute.name,
              redirectTo: 'signIn',
              fullMatch: true,
            ),
            _i15.RouteConfig(
              SignInRoute.name,
              path: 'signIn',
              parent: AuthenticationWrapperRoute.name,
            ),
            _i15.RouteConfig(
              RegisterRoute.name,
              path: 'register',
              parent: AuthenticationWrapperRoute.name,
            ),
          ],
        ),
        _i15.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i15.RouteConfig(
              '#redirect',
              path: '',
              parent: HomeRoute.name,
              redirectTo: 'notes',
              fullMatch: true,
            ),
            _i15.RouteConfig(
              NotesWrapperRoute.name,
              path: 'notes',
              parent: HomeRoute.name,
              children: [
                _i15.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: NotesWrapperRoute.name,
                  redirectTo: 'noteList',
                  fullMatch: true,
                ),
                _i15.RouteConfig(
                  NoteListRoute.name,
                  path: 'noteList',
                  parent: NotesWrapperRoute.name,
                ),
                _i15.RouteConfig(
                  NotePreviewRoute.name,
                  path: 'notePreview',
                  parent: NotesWrapperRoute.name,
                ),
                _i15.RouteConfig(
                  NewNoteRoute.name,
                  path: 'newNote',
                  parent: NotesWrapperRoute.name,
                ),
                _i15.RouteConfig(
                  UpdateNoteRoute.name,
                  path: 'updateNote',
                  parent: NotesWrapperRoute.name,
                ),
                _i15.RouteConfig(
                  TagsManageRoute.name,
                  path: 'tagsManager',
                  parent: NotesWrapperRoute.name,
                ),
              ],
            ),
            _i15.RouteConfig(
              UserAccountWrapperRoute.name,
              path: 'userAccount',
              parent: HomeRoute.name,
              children: [
                _i15.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: UserAccountWrapperRoute.name,
                  redirectTo: 'preview',
                  fullMatch: true,
                ),
                _i15.RouteConfig(
                  UserAccountPreviewRoute.name,
                  path: 'preview',
                  parent: UserAccountWrapperRoute.name,
                ),
                _i15.RouteConfig(
                  UserAccountUpdateRoute.name,
                  path: 'update',
                  parent: UserAccountWrapperRoute.name,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.AuthenticationWrapperPage]
class AuthenticationWrapperRoute extends _i15.PageRouteInfo<void> {
  const AuthenticationWrapperRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AuthenticationWrapperRoute.name,
          path: '/authentication',
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapperRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.SignInPage]
class SignInRoute extends _i15.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: 'signIn',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i5.RegisterPage]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i6.NotesWrapperPage]
class NotesWrapperRoute extends _i15.PageRouteInfo<void> {
  const NotesWrapperRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NotesWrapperRoute.name,
          path: 'notes',
          initialChildren: children,
        );

  static const String name = 'NotesWrapperRoute';
}

/// generated route for
/// [_i7.UserAccountWrapperPage]
class UserAccountWrapperRoute extends _i15.PageRouteInfo<void> {
  const UserAccountWrapperRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserAccountWrapperRoute.name,
          path: 'userAccount',
          initialChildren: children,
        );

  static const String name = 'UserAccountWrapperRoute';
}

/// generated route for
/// [_i8.NoteListPage]
class NoteListRoute extends _i15.PageRouteInfo<void> {
  const NoteListRoute()
      : super(
          NoteListRoute.name,
          path: 'noteList',
        );

  static const String name = 'NoteListRoute';
}

/// generated route for
/// [_i9.NotePreviewPage]
class NotePreviewRoute extends _i15.PageRouteInfo<NotePreviewRouteArgs> {
  NotePreviewRoute({
    _i16.Key? key,
    required String noteId,
  }) : super(
          NotePreviewRoute.name,
          path: 'notePreview',
          args: NotePreviewRouteArgs(
            key: key,
            noteId: noteId,
          ),
        );

  static const String name = 'NotePreviewRoute';
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
/// [_i10.NewNotePage]
class NewNoteRoute extends _i15.PageRouteInfo<void> {
  const NewNoteRoute()
      : super(
          NewNoteRoute.name,
          path: 'newNote',
        );

  static const String name = 'NewNoteRoute';
}

/// generated route for
/// [_i11.UpdateNotePage]
class UpdateNoteRoute extends _i15.PageRouteInfo<UpdateNoteRouteArgs> {
  UpdateNoteRoute({
    _i16.Key? key,
    required String noteId,
  }) : super(
          UpdateNoteRoute.name,
          path: 'updateNote',
          args: UpdateNoteRouteArgs(
            key: key,
            noteId: noteId,
          ),
        );

  static const String name = 'UpdateNoteRoute';
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
/// [_i12.TagsManagePage]
class TagsManageRoute extends _i15.PageRouteInfo<void> {
  const TagsManageRoute()
      : super(
          TagsManageRoute.name,
          path: 'tagsManager',
        );

  static const String name = 'TagsManageRoute';
}

/// generated route for
/// [_i13.UserAccountPreviewPage]
class UserAccountPreviewRoute extends _i15.PageRouteInfo<void> {
  const UserAccountPreviewRoute()
      : super(
          UserAccountPreviewRoute.name,
          path: 'preview',
        );

  static const String name = 'UserAccountPreviewRoute';
}

/// generated route for
/// [_i14.UserAccountUpdatePage]
class UserAccountUpdateRoute extends _i15.PageRouteInfo<void> {
  const UserAccountUpdateRoute()
      : super(
          UserAccountUpdateRoute.name,
          path: 'update',
        );

  static const String name = 'UserAccountUpdateRoute';
}
