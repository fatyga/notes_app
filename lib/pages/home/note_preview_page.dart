import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NotePreviewPage extends StatelessWidget {
  const NotePreviewPage({super.key, required this.selectedNoteIndex});

  final selectedNoteIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);

    final selectedNote = provider.notes[selectedNoteIndex];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                context.router.push(NoteManipulationPageRoute(
                    selectedNoteIndex: selectedNoteIndex));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                provider.pinUnpin(selectedNoteIndex);
              },
              icon: Icon(
                (selectedNote.isPinned)
                    ? Icons.push_pin
                    : Icons.push_pin_outlined,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(selectedNote.title,
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 20),
            Text(selectedNote.createdAt,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.grey)),
            const SizedBox(height: 20),
            Text(selectedNote.content,
                style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
      ),
    );
  }
}
