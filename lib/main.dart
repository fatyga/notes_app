import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
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
