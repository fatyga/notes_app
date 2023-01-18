import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/authentication/services/authentication_repository.dart';

import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/themes/dark_theme.dart';
import 'package:notes_app/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository authentication =
        serviceLocator<AuthenticationRepository>();

    return StreamBuilder(
      stream: authentication.authenticationChanges,
      builder: (context, snapshot) => MaterialApp.router(
        routerDelegate: AutoRouterDelegate.declarative(_appRouter,
            routes: (_) => [
                  if (snapshot.data != null)
                    const HomeRoute()
                  else
                    const AuthenticationWrapperRoute()
                ]),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
      ),
    );
  }
}
