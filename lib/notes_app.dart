import 'package:flutter/material.dart';
import 'package:notes_app/core/route/app_router.gr.dart';

import 'package:notes_app/themes/dark_theme.dart';
import 'package:notes_app/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
    );
  }
}
