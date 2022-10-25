import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/database/db.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:provider/provider.dart';

class NotePreviewPage extends StatelessWidget {
  NotePreviewPage({super.key, required this.selectedNoteId});

  final String selectedNoteId;

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
                context.router
                    .push(UpdateNoteRoute(selectedNoteId: selectedNoteId));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                final selectedNote =
                    Provider.of<List<Note>>(context, listen: false)
                        .firstWhere((element) => element.id == selectedNoteId);

                await db.updateNote(
                    user!, selectedNote, {'pinned': !selectedNote.pinned});
              },
              icon: (Provider.of<List<Note>>(context)
                      .firstWhere((element) => element.id == selectedNoteId)
                      .pinned)
                  ? const Icon(Icons.push_pin_rounded)
                  : const Icon(
                      Icons.push_pin_outlined,
                    )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Consumer<List<Note>>(
          builder: (context, value, child) {
            final selectedNote =
                value.firstWhere((element) => element.id == selectedNoteId);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(selectedNote.title,
                    style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: 20),
                Text(selectedNote.formattedTime,
                    style: Theme.of(context).textTheme.subtitle2),
                const SizedBox(height: 20),
                Text(selectedNote.content,
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            );
          },
        ),
      ),
    );
  }
}
