import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:notes_app/notes/services/notes_service.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:provider/provider.dart';

class NotesWrapperPage extends StatelessWidget {
  const NotesWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
    // final firestore = Provider.of<FirestoreService>(context);

    // return MultiProvider(providers: [
    //   StreamProvider<List<Note>>.value(
    //       initialData: const [], value: firestore.streamNotes),
    //   StreamProvider<UserAccount?>.value(
    //       initialData: null, value: firestore.streamUserAccount)
    // ], child: const AutoRouter());
  }
}
