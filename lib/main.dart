import 'package:flutter/material.dart';

import 'package:notes_app/notes.dart';
import 'package:notes_app/notes_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Notes(),
      child: const NotesApp(),
    ),
  );
}
