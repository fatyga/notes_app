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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../pages/authenticate/register_page.dart' as _i2;
import '../../pages/authenticate/sign_in_page.dart' as _i1;
import '../../pages/home/home_page.dart' as _i3;
import '../../pages/home/note_manipulation_page.dart' as _i4;
import '../../pages/home/note_preview_page.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SignInPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SignInPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    NoteManipulationPageRoute.name: (routeData) {
      final args = routeData.argsAs<NoteManipulationPageRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.NoteManipulationPage(
          key: args.key,
          selectedNoteIndex: args.selectedNoteIndex,
        ),
      );
    },
    NotePreviewPageRoute.name: (routeData) {
      final args = routeData.argsAs<NotePreviewPageRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.NotePreviewPage(
          key: args.key,
          selectedNoteIndex: args.selectedNoteIndex,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SignInPageRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i6.RouteConfig(
          HomePageRoute.name,
          path: '/home-page',
        ),
        _i6.RouteConfig(
          NoteManipulationPageRoute.name,
          path: '/note-manipulation-page',
        ),
        _i6.RouteConfig(
          NotePreviewPageRoute.name,
          path: '/note-preview-page',
        ),
      ];
}

/// generated route for
/// [_i1.SignInPage]
class SignInPageRoute extends _i6.PageRouteInfo<void> {
  const SignInPageRoute()
      : super(
          SignInPageRoute.name,
          path: '/',
        );

  static const String name = 'SignInPageRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterPageRoute extends _i6.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomePageRoute extends _i6.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: '/home-page',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i4.NoteManipulationPage]
class NoteManipulationPageRoute
    extends _i6.PageRouteInfo<NoteManipulationPageRouteArgs> {
  NoteManipulationPageRoute({
    _i7.Key? key,
    required dynamic selectedNoteIndex,
  }) : super(
          NoteManipulationPageRoute.name,
          path: '/note-manipulation-page',
          args: NoteManipulationPageRouteArgs(
            key: key,
            selectedNoteIndex: selectedNoteIndex,
          ),
        );

  static const String name = 'NoteManipulationPageRoute';
}

class NoteManipulationPageRouteArgs {
  const NoteManipulationPageRouteArgs({
    this.key,
    required this.selectedNoteIndex,
  });

  final _i7.Key? key;

  final dynamic selectedNoteIndex;

  @override
  String toString() {
    return 'NoteManipulationPageRouteArgs{key: $key, selectedNoteIndex: $selectedNoteIndex}';
  }
}

/// generated route for
/// [_i5.NotePreviewPage]
class NotePreviewPageRoute extends _i6.PageRouteInfo<NotePreviewPageRouteArgs> {
  NotePreviewPageRoute({
    _i7.Key? key,
    required dynamic selectedNoteIndex,
  }) : super(
          NotePreviewPageRoute.name,
          path: '/note-preview-page',
          args: NotePreviewPageRouteArgs(
            key: key,
            selectedNoteIndex: selectedNoteIndex,
          ),
        );

  static const String name = 'NotePreviewPageRoute';
}

class NotePreviewPageRouteArgs {
  const NotePreviewPageRouteArgs({
    this.key,
    required this.selectedNoteIndex,
  });

  final _i7.Key? key;

  final dynamic selectedNoteIndex;

  @override
  String toString() {
    return 'NotePreviewPageRouteArgs{key: $key, selectedNoteIndex: $selectedNoteIndex}';
  }
}
