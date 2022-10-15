import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:notes_app/notes.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.noteIndex});

  final int noteIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);
    final selectedNote = provider.notes[noteIndex];

    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () {
              final provider = Provider.of<Notes>(context, listen: false);
              context.router
                  .push(NotePreviewPageRoute(selectedNoteIndex: noteIndex));
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: selectedNote.backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(selectedNote.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 15),
                    Text(selectedNote.createdAt,
                        style: Theme.of(context).textTheme.subtitle2),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
