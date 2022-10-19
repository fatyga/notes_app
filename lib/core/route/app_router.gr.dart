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
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../pages/authenticate/authenticate_top_page.dart' as _i1;
import '../../pages/authenticate/register_page.dart' as _i4;
import '../../pages/authenticate/sign_in_page.dart' as _i3;
import '../../pages/home/home_top_page.dart' as _i2;
import '../../pages/home/note_list_page.dart' as _i5;
import '../../pages/home/note_manipulation_page.dart' as _i7;
import '../../pages/home/note_preview_page.dart' as _i6;
import '../database/models.dart' as _i10;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AuthenticateTopRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticateTopPage(),
      );
    },
    HomeTopRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomeTopPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignInPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
    NoteListRoute.name: (routeData) {
      final args = routeData.argsAs<NoteListRouteArgs>(
          orElse: () => const NoteListRouteArgs());
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.NoteListPage(key: args.key),
      );
    },
    NotePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<NotePreviewRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.NotePreviewPage(
          key: args.key,
          selectedNote: args.selectedNote,
        ),
      );
    },
    NoteManipulationRoute.name: (routeData) {
      final args = routeData.argsAs<NoteManipulationRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.NoteManipulationPage(
          key: args.key,
          selectedNote: args.selectedNote,
        ),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/authentication',
          fullMatch: true,
        ),
        _i8.RouteConfig(
          AuthenticateTopRoute.name,
          path: '/authentication',
          children: [
            _i8.RouteConfig(
              '#redirect',
              path: '',
              parent: AuthenticateTopRoute.name,
              redirectTo: 'signIn',
              fullMatch: true,
            ),
            _i8.RouteConfig(
              SignInRoute.name,
              path: 'signIn',
              parent: AuthenticateTopRoute.name,
            ),
            _i8.RouteConfig(
              RegisterRoute.name,
              path: 'register',
              parent: AuthenticateTopRoute.name,
            ),
          ],
        ),
        _i8.RouteConfig(
          HomeTopRoute.name,
          path: '/home',
          children: [
            _i8.RouteConfig(
              '#redirect',
              path: '',
              parent: HomeTopRoute.name,
              redirectTo: 'noteList',
              fullMatch: true,
            ),
            _i8.RouteConfig(
              NoteListRoute.name,
              path: 'noteList',
              parent: HomeTopRoute.name,
            ),
            _i8.RouteConfig(
              NotePreviewRoute.name,
              path: 'notePreview',
              parent: HomeTopRoute.name,
            ),
            _i8.RouteConfig(
              NoteManipulationRoute.name,
              path: 'noteManipulation',
              parent: HomeTopRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthenticateTopPage]
class AuthenticateTopRoute extends _i8.PageRouteInfo<void> {
  const AuthenticateTopRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AuthenticateTopRoute.name,
          path: '/authentication',
          initialChildren: children,
        );

  static const String name = 'AuthenticateTopRoute';
}

/// generated route for
/// [_i2.HomeTopPage]
class HomeTopRoute extends _i8.PageRouteInfo<void> {
  const HomeTopRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeTopRoute.name,
          path: '/home',
          initialChildren: children,
        );

  static const String name = 'HomeTopRoute';
}

/// generated route for
/// [_i3.SignInPage]
class SignInRoute extends _i8.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: 'signIn',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i8.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.NoteListPage]
class NoteListRoute extends _i8.PageRouteInfo<NoteListRouteArgs> {
  NoteListRoute({_i9.Key? key})
      : super(
          NoteListRoute.name,
          path: 'noteList',
          args: NoteListRouteArgs(key: key),
        );

  static const String name = 'NoteListRoute';
}

class NoteListRouteArgs {
  const NoteListRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'NoteListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.NotePreviewPage]
class NotePreviewRoute extends _i8.PageRouteInfo<NotePreviewRouteArgs> {
  NotePreviewRoute({
    _i9.Key? key,
    required _i10.Note selectedNote,
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

  final _i9.Key? key;

  final _i10.Note selectedNote;

  @override
  String toString() {
    return 'NotePreviewRouteArgs{key: $key, selectedNote: $selectedNote}';
  }
}

/// generated route for
/// [_i7.NoteManipulationPage]
class NoteManipulationRoute
    extends _i8.PageRouteInfo<NoteManipulationRouteArgs> {
  NoteManipulationRoute({
    _i9.Key? key,
    required _i10.Note? selectedNote,
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

  final _i9.Key? key;

  final _i10.Note? selectedNote;

  @override
  String toString() {
    return 'NoteManipulationRouteArgs{key: $key, selectedNote: $selectedNote}';
  }
}
