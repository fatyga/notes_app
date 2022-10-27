import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/database/firestore_service.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:provider/provider.dart';

class NotesWrapperPage extends StatelessWidget {
  const NotesWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamProvider<List<Note>>.value(
        initialData: [],
        value: user != null ? FirestoreService().streamNotes(user) : null,
        child: AutoRouter());
  }
}
