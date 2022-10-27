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
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import '../../pages/authentication/authentication_wrapper_page.dart' as _i1;
import '../../pages/authentication/register_page.dart' as _i4;
import '../../pages/authentication/sign_in_page.dart' as _i3;
import '../../pages/home/notes/new_note_page.dart' as _i9;
import '../../pages/home/notes/note_list_page.dart' as _i7;
import '../../pages/home/notes/note_preview_page.dart' as _i8;
import '../../pages/home/notes/notes_wrapper_page.dart' as _i5;
import '../../pages/home/notes/update_note_page.dart' as _i10;
import '../../pages/home/userAccount/user_account_info_page.dart' as _i11;
import '../../pages/home/userAccount/user_account_wrapper_page.dart' as _i6;
import '../../pages/home/wrapper.dart' as _i2;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    AuthenticationWrapperRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapperPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignInPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
    NotesWrapperRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.NotesWrapperPage(),
      );
    },
    UserAccountWrapperRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.UserAccountWrapperPage(),
      );
    },
    NoteListRoute.name: (routeData) {
      final args = routeData.argsAs<NoteListRouteArgs>(
          orElse: () => const NoteListRouteArgs());
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.NoteListPage(key: args.key),
      );
    },
    NotePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<NotePreviewRouteArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.NotePreviewPage(
          key: args.key,
          selectedNoteId: args.selectedNoteId,
        ),
      );
    },
    NewNoteRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.NewNotePage(),
      );
    },
    UpdateNoteRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateNoteRouteArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.UpdateNotePage(
          key: args.key,
          selectedNoteId: args.selectedNoteId,
        ),
      );
    },
    UserAccountInfoRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.UserAccountInfoPage(),
      );
    },
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(
          AuthenticationWrapperRoute.name,
          path: '/authentication',
          children: [
            _i12.RouteConfig(
              '#redirect',
              path: '',
              parent: AuthenticationWrapperRoute.name,
              redirectTo: 'signIn',
              fullMatch: true,
            ),
            _i12.RouteConfig(
              SignInRoute.name,
              path: 'signIn',
              parent: AuthenticationWrapperRoute.name,
            ),
            _i12.RouteConfig(
              RegisterRoute.name,
              path: 'register',
              parent: AuthenticationWrapperRoute.name,
            ),
          ],
        ),
        _i12.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i12.RouteConfig(
              '#redirect',
              path: '',
              parent: HomeRoute.name,
              redirectTo: 'notes',
              fullMatch: true,
            ),
            _i12.RouteConfig(
              NotesWrapperRoute.name,
              path: 'notes',
              parent: HomeRoute.name,
              children: [
                _i12.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: NotesWrapperRoute.name,
                  redirectTo: 'noteList',
                  fullMatch: true,
                ),
                _i12.RouteConfig(
                  NoteListRoute.name,
                  path: 'noteList',
                  parent: NotesWrapperRoute.name,
                ),
                _i12.RouteConfig(
                  NotePreviewRoute.name,
                  path: 'notePreview',
                  parent: NotesWrapperRoute.name,
                ),
                _i12.RouteConfig(
                  NewNoteRoute.name,
                  path: 'newNote',
                  parent: NotesWrapperRoute.name,
                ),
                _i12.RouteConfig(
                  UpdateNoteRoute.name,
                  path: 'updateNote',
                  parent: NotesWrapperRoute.name,
                ),
              ],
            ),
            _i12.RouteConfig(
              UserAccountWrapperRoute.name,
              path: 'userAccount',
              parent: HomeRoute.name,
              children: [
                _i12.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: UserAccountWrapperRoute.name,
                  redirectTo: 'info',
                  fullMatch: true,
                ),
                _i12.RouteConfig(
                  UserAccountInfoRoute.name,
                  path: 'info',
                  parent: UserAccountWrapperRoute.name,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthenticationWrapperPage]
class AuthenticationWrapperRoute extends _i12.PageRouteInfo<void> {
  const AuthenticationWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AuthenticationWrapperRoute.name,
          path: '/authentication',
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapperRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.SignInPage]
class SignInRoute extends _i12.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: 'signIn',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i12.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.NotesWrapperPage]
class NotesWrapperRoute extends _i12.PageRouteInfo<void> {
  const NotesWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(
          NotesWrapperRoute.name,
          path: 'notes',
          initialChildren: children,
        );

  static const String name = 'NotesWrapperRoute';
}

/// generated route for
/// [_i6.UserAccountWrapperPage]
class UserAccountWrapperRoute extends _i12.PageRouteInfo<void> {
  const UserAccountWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(
          UserAccountWrapperRoute.name,
          path: 'userAccount',
          initialChildren: children,
        );

  static const String name = 'UserAccountWrapperRoute';
}

/// generated route for
/// [_i7.NoteListPage]
class NoteListRoute extends _i12.PageRouteInfo<NoteListRouteArgs> {
  NoteListRoute({_i13.Key? key})
      : super(
          NoteListRoute.name,
          path: 'noteList',
          args: NoteListRouteArgs(key: key),
        );

  static const String name = 'NoteListRoute';
}

class NoteListRouteArgs {
  const NoteListRouteArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'NoteListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.NotePreviewPage]
class NotePreviewRoute extends _i12.PageRouteInfo<NotePreviewRouteArgs> {
  NotePreviewRoute({
    _i13.Key? key,
    required String selectedNoteId,
  }) : super(
          NotePreviewRoute.name,
          path: 'notePreview',
          args: NotePreviewRouteArgs(
            key: key,
            selectedNoteId: selectedNoteId,
          ),
        );

  static const String name = 'NotePreviewRoute';
}

class NotePreviewRouteArgs {
  const NotePreviewRouteArgs({
    this.key,
    required this.selectedNoteId,
  });

  final _i13.Key? key;

  final String selectedNoteId;

  @override
  String toString() {
    return 'NotePreviewRouteArgs{key: $key, selectedNoteId: $selectedNoteId}';
  }
}

/// generated route for
/// [_i9.NewNotePage]
class NewNoteRoute extends _i12.PageRouteInfo<void> {
  const NewNoteRoute()
      : super(
          NewNoteRoute.name,
          path: 'newNote',
        );

  static const String name = 'NewNoteRoute';
}

/// generated route for
/// [_i10.UpdateNotePage]
class UpdateNoteRoute extends _i12.PageRouteInfo<UpdateNoteRouteArgs> {
  UpdateNoteRoute({
    _i13.Key? key,
    required String selectedNoteId,
  }) : super(
          UpdateNoteRoute.name,
          path: 'updateNote',
          args: UpdateNoteRouteArgs(
            key: key,
            selectedNoteId: selectedNoteId,
          ),
        );

  static const String name = 'UpdateNoteRoute';
}

class UpdateNoteRouteArgs {
  const UpdateNoteRouteArgs({
    this.key,
    required this.selectedNoteId,
  });

  final _i13.Key? key;

  final String selectedNoteId;

  @override
  String toString() {
    return 'UpdateNoteRouteArgs{key: $key, selectedNoteId: $selectedNoteId}';
  }
}

/// generated route for
/// [_i11.UserAccountInfoPage]
class UserAccountInfoRoute extends _i12.PageRouteInfo<void> {
  const UserAccountInfoRoute()
      : super(
          UserAccountInfoRoute.name,
          path: 'info',
        );

  static const String name = 'UserAccountInfoRoute';
}
