import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/database/db.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NotePreviewPage extends StatelessWidget {
  NotePreviewPage({super.key, required this.selectedNote});

  final Note selectedNote;

  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                // context.router.push(NoteManipulationRoute(
                //     selectedNoteIndex: selectedNoteIndex));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.push_pin_outlined,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(selectedNote.id),
            Text(selectedNote.title,
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Text(selectedNote.content,
                style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
      ),
    );
  }
}
