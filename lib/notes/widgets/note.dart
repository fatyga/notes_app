import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/notes_view_model.dart';
import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/service_locator.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () {
              serviceLocator<NotesViewModel>().selectNote(note);

              context.router.push(NotePreviewRoute(noteId: note.id));
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(note.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 15),
                    Text(note.formattedTime,
                        style: Theme.of(context).textTheme.subtitle2),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
