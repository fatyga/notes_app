import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/screens/new_note.dart';
import 'package:notes_app/screens/note_preview.dart';
import 'package:notes_app/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/newNote': (context) => const NewNote(),
        '/noteView': (context) => const NotePreview()
      },
    );
  }
}
