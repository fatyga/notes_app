import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/authentication/auth.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:notes_app/pages/home/notes/notes_wrapper_page.dart';
import 'package:notes_app/themes/dark_theme.dart';
import 'package:notes_app/themes/light_theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate.declarative(_appRouter,
          routes: (_) => [
                if (user != null)
                  const HomeRoute()
                else
                  const AuthenticationWrapperRoute()
              ]),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
    );
  }
}
