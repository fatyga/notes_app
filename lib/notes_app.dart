import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/notes/notes.dart';
import 'package:notes_app/route/app_router.dart';

import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/notes_mode.dart';

import 'package:notes_app/themes/dark_theme.dart';
import 'package:notes_app/themes/light_theme.dart';
import 'package:rxdart/rxdart.dart';

import 'authentication/authentication.dart';

final _appRouter = AppRouter();

enum AuthenticationStatus { initial, userAuthenticated, userNotAuthenticated }

class NotesAppData {
  const NotesAppData(
      {required this.authenticationStatus,
      this.notesFromFirstFetch = const []});
  final AuthenticationStatus authenticationStatus;
  final List<Note> notesFromFirstFetch;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthenticationRepository authentication =
      serviceLocator<AuthenticationRepository>();
  final NotesRepository notes = serviceLocator<NotesRepository>();

  late Stream<NotesAppData> authenticationChanges;

  @override
  void initState() {
    authenticationChanges = authentication.authenticationChanges.map<
        AuthenticationStatus>((AppUser? user) {
      if (user == null) {
        return AuthenticationStatus.userNotAuthenticated;
      } else {
        return AuthenticationStatus.userAuthenticated;
      }
    }).asyncMap<NotesAppData>((authStatus) async {
      if (authStatus == AuthenticationStatus.userAuthenticated) {
        final notesFromFirstFetch = await notes.notesChanges.take(1).last;
        print(notesFromFirstFetch);
        return NotesAppData(
            authenticationStatus: authStatus,
            notesFromFirstFetch: notesFromFirstFetch);
      } else {
        return NotesAppData(authenticationStatus: authStatus);
      }
    }).startWith(
        const NotesAppData(authenticationStatus: AuthenticationStatus.initial));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NotesAppData>(
      stream: authenticationChanges,
      builder: (context, AsyncSnapshot<NotesAppData> snapshot) =>
          MaterialApp.router(
        routerDelegate: AutoRouterDelegate.declarative(_appRouter,
            routes: (_) => [
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData ||
                      snapshot.data?.authenticationStatus ==
                          AuthenticationStatus.initial)
                    const SplashRoute()
                  else if (snapshot.data?.authenticationStatus ==
                      AuthenticationStatus.userAuthenticated)
                    HomeRouter(children: [
                      NotesRouter(children: [
                        NoteListRoute(
                            notesFromInitialFetch:
                                snapshot.data!.notesFromFirstFetch)
                      ])
                    ])
                  else
                    const AuthenticationRouter()
                ]),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
      ),
    );
  }
}
