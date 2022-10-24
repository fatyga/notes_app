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
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../../pages/authentication/authentication_wrapper_page.dart' as _i1;
import '../../pages/authentication/register_page.dart' as _i4;
import '../../pages/authentication/sign_in_page.dart' as _i3;
import '../../pages/home/notes/new_note_page.dart' as _i8;
import '../../pages/home/notes/note_list_page.dart' as _i6;
import '../../pages/home/notes/note_preview_page.dart' as _i7;
import '../../pages/home/notes/notes_wrapper_page.dart' as _i5;
import '../../pages/home/notes/update_note_page.dart' as _i9;
import '../../pages/home/wrapper.dart' as _i2;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AuthenticationWrapperRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapperPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignInPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
    NotesWrapperRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.NotesWrapperPage(),
      );
    },
    NoteListRoute.name: (routeData) {
      final args = routeData.argsAs<NoteListRouteArgs>(
          orElse: () => const NoteListRouteArgs());
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.NoteListPage(key: args.key),
      );
    },
    NotePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<NotePreviewRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.NotePreviewPage(
          key: args.key,
          selectedNoteId: args.selectedNoteId,
        ),
      );
    },
    NewNoteRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.NewNotePage(),
      );
    },
    UpdateNoteRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateNoteRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.UpdateNotePage(
          key: args.key,
          selectedNoteId: args.selectedNoteId,
        ),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          AuthenticationWrapperRoute.name,
          path: '/authentication',
          children: [
            _i10.RouteConfig(
              '#redirect',
              path: '',
              parent: AuthenticationWrapperRoute.name,
              redirectTo: 'signIn',
              fullMatch: true,
            ),
            _i10.RouteConfig(
              SignInRoute.name,
              path: 'signIn',
              parent: AuthenticationWrapperRoute.name,
            ),
            _i10.RouteConfig(
              RegisterRoute.name,
              path: 'register',
              parent: AuthenticationWrapperRoute.name,
            ),
          ],
        ),
        _i10.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i10.RouteConfig(
              '#redirect',
              path: '',
              parent: HomeRoute.name,
              redirectTo: 'notes',
              fullMatch: true,
            ),
            _i10.RouteConfig(
              NotesWrapperRoute.name,
              path: 'notes',
              parent: HomeRoute.name,
              children: [
                _i10.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: NotesWrapperRoute.name,
                  redirectTo: 'noteList',
                  fullMatch: true,
                ),
                _i10.RouteConfig(
                  NoteListRoute.name,
                  path: 'noteList',
                  parent: NotesWrapperRoute.name,
                ),
                _i10.RouteConfig(
                  NotePreviewRoute.name,
                  path: 'notePreview',
                  parent: NotesWrapperRoute.name,
                ),
                _i10.RouteConfig(
                  NewNoteRoute.name,
                  path: 'newNote',
                  parent: NotesWrapperRoute.name,
                ),
                _i10.RouteConfig(
                  UpdateNoteRoute.name,
                  path: 'updateNote',
                  parent: NotesWrapperRoute.name,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthenticationWrapperPage]
class AuthenticationWrapperRoute extends _i10.PageRouteInfo<void> {
  const AuthenticationWrapperRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AuthenticationWrapperRoute.name,
          path: '/authentication',
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapperRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.SignInPage]
class SignInRoute extends _i10.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: 'signIn',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i10.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.NotesWrapperPage]
class NotesWrapperRoute extends _i10.PageRouteInfo<void> {
  const NotesWrapperRoute({List<_i10.PageRouteInfo>? children})
      : super(
          NotesWrapperRoute.name,
          path: 'notes',
          initialChildren: children,
        );

  static const String name = 'NotesWrapperRoute';
}

/// generated route for
/// [_i6.NoteListPage]
class NoteListRoute extends _i10.PageRouteInfo<NoteListRouteArgs> {
  NoteListRoute({_i11.Key? key})
      : super(
          NoteListRoute.name,
          path: 'noteList',
          args: NoteListRouteArgs(key: key),
        );

  static const String name = 'NoteListRoute';
}

class NoteListRouteArgs {
  const NoteListRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'NoteListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.NotePreviewPage]
class NotePreviewRoute extends _i10.PageRouteInfo<NotePreviewRouteArgs> {
  NotePreviewRoute({
    _i11.Key? key,
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

  final _i11.Key? key;

  final String selectedNoteId;

  @override
  String toString() {
    return 'NotePreviewRouteArgs{key: $key, selectedNoteId: $selectedNoteId}';
  }
}

/// generated route for
/// [_i8.NewNotePage]
class NewNoteRoute extends _i10.PageRouteInfo<void> {
  const NewNoteRoute()
      : super(
          NewNoteRoute.name,
          path: 'newNote',
        );

  static const String name = 'NewNoteRoute';
}

/// generated route for
/// [_i9.UpdateNotePage]
class UpdateNoteRoute extends _i10.PageRouteInfo<UpdateNoteRouteArgs> {
  UpdateNoteRoute({
    _i11.Key? key,
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

  final _i11.Key? key;

  final String selectedNoteId;

  @override
  String toString() {
    return 'UpdateNoteRouteArgs{key: $key, selectedNoteId: $selectedNoteId}';
  }
}
