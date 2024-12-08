import 'package:flutter/material.dart';

import 'package:notes_app/route/app_router.dart';

import 'package:notes_app/themes/dark_theme.dart';
import 'package:notes_app/themes/light_theme.dart';

final _appRouter = AppRouter();

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
    );
  }
}
