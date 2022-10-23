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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../pages/authentication/authentication_wrapper_page.dart' as _i1;
import '../../pages/authentication/register_page.dart' as _i4;
import '../../pages/authentication/sign_in_page.dart' as _i3;
import '../../pages/home/notes/note_list_page.dart' as _i6;
import '../../pages/home/notes/note_manipulation_page.dart' as _i8;
import '../../pages/home/notes/note_preview_page.dart' as _i7;
import '../../pages/home/notes/notes_wrapper_page.dart' as _i5;
import '../../pages/home/wrapper.dart' as _i2;
import '../database/models.dart' as _i11;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AuthenticationWrapperRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapperPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignInPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
    NotesWrapperRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.NotesWrapperPage(),
      );
    },
    NoteListRoute.name: (routeData) {
      final args = routeData.argsAs<NoteListRouteArgs>(
          orElse: () => const NoteListRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.NoteListPage(key: args.key),
      );
    },
    NotePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<NotePreviewRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.NotePreviewPage(
          key: args.key,
          selectedNote: args.selectedNote,
        ),
      );
    },
    NoteManipulationRoute.name: (routeData) {
      final args = routeData.argsAs<NoteManipulationRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.NoteManipulationPage(
          key: args.key,
          selectedNote: args.selectedNote,
        ),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          AuthenticationWrapperRoute.name,
          path: '/authentication',
          children: [
            _i9.RouteConfig(
              '#redirect',
              path: '',
              parent: AuthenticationWrapperRoute.name,
              redirectTo: 'signIn',
              fullMatch: true,
            ),
            _i9.RouteConfig(
              SignInRoute.name,
              path: 'signIn',
              parent: AuthenticationWrapperRoute.name,
            ),
            _i9.RouteConfig(
              RegisterRoute.name,
              path: 'register',
              parent: AuthenticationWrapperRoute.name,
            ),
          ],
        ),
        _i9.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i9.RouteConfig(
              '#redirect',
              path: '',
              parent: HomeRoute.name,
              redirectTo: 'notes',
              fullMatch: true,
            ),
            _i9.RouteConfig(
              NotesWrapperRoute.name,
              path: 'notes',
              parent: HomeRoute.name,
              children: [
                _i9.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: NotesWrapperRoute.name,
                  redirectTo: 'noteList',
                  fullMatch: true,
                ),
                _i9.RouteConfig(
                  NoteListRoute.name,
                  path: 'noteList',
                  parent: NotesWrapperRoute.name,
                ),
                _i9.RouteConfig(
                  NotePreviewRoute.name,
                  path: 'notePreview',
                  parent: NotesWrapperRoute.name,
                ),
                _i9.RouteConfig(
                  NoteManipulationRoute.name,
                  path: 'noteManipulation',
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
class AuthenticationWrapperRoute extends _i9.PageRouteInfo<void> {
  const AuthenticationWrapperRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AuthenticationWrapperRoute.name,
          path: '/authentication',
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapperRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.SignInPage]
class SignInRoute extends _i9.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: 'signIn',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.NotesWrapperPage]
class NotesWrapperRoute extends _i9.PageRouteInfo<void> {
  const NotesWrapperRoute({List<_i9.PageRouteInfo>? children})
      : super(
          NotesWrapperRoute.name,
          path: 'notes',
          initialChildren: children,
        );

  static const String name = 'NotesWrapperRoute';
}

/// generated route for
/// [_i6.NoteListPage]
class NoteListRoute extends _i9.PageRouteInfo<NoteListRouteArgs> {
  NoteListRoute({_i10.Key? key})
      : super(
          NoteListRoute.name,
          path: 'noteList',
          args: NoteListRouteArgs(key: key),
        );

  static const String name = 'NoteListRoute';
}

class NoteListRouteArgs {
  const NoteListRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'NoteListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.NotePreviewPage]
class NotePreviewRoute extends _i9.PageRouteInfo<NotePreviewRouteArgs> {
  NotePreviewRoute({
    _i10.Key? key,
    required _i11.Note selectedNote,
  }) : super(
          NotePreviewRoute.name,
          path: 'notePreview',
          args: NotePreviewRouteArgs(
            key: key,
            selectedNote: selectedNote,
          ),
        );

  static const String name = 'NotePreviewRoute';
}

class NotePreviewRouteArgs {
  const NotePreviewRouteArgs({
    this.key,
    required this.selectedNote,
  });

  final _i10.Key? key;

  final _i11.Note selectedNote;

  @override
  String toString() {
    return 'NotePreviewRouteArgs{key: $key, selectedNote: $selectedNote}';
  }
}

/// generated route for
/// [_i8.NoteManipulationPage]
class NoteManipulationRoute
    extends _i9.PageRouteInfo<NoteManipulationRouteArgs> {
  NoteManipulationRoute({
    _i10.Key? key,
    required _i11.Note? selectedNote,
  }) : super(
          NoteManipulationRoute.name,
          path: 'noteManipulation',
          args: NoteManipulationRouteArgs(
            key: key,
            selectedNote: selectedNote,
          ),
        );

  static const String name = 'NoteManipulationRoute';
}

class NoteManipulationRouteArgs {
  const NoteManipulationRouteArgs({
    this.key,
    required this.selectedNote,
  });

  final _i10.Key? key;

  final _i11.Note? selectedNote;

  @override
  String toString() {
    return 'NoteManipulationRouteArgs{key: $key, selectedNote: $selectedNote}';
  }
}
