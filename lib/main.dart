import 'package:flutter/material.dart';
import 'package:notes_app/notes.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/screens/new_note.dart';
import 'package:notes_app/screens/note_preview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Notes(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/newNote': (context) => NewNote(),
        '/noteView': (context) => NotePreview()
      },
    );
  }
}
