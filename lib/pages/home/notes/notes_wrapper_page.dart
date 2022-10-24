import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/database/db.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:provider/provider.dart';

class NotesWrapperPage extends StatefulWidget {
  const NotesWrapperPage({super.key});

  @override
  State<NotesWrapperPage> createState() => _NotesWrapperPageState();
}

class _NotesWrapperPageState extends State<NotesWrapperPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamProvider<List<Note>>.value(
        initialData: [],
        value: user != null ? DatabaseService().streamNotes(user) : null,
        child: AutoRouter());
  }
}
