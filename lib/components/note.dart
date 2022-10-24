import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () {
              context.router.push(NotePreviewRoute(selectedNoteId: note.id));
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                // color: note.backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(note.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 15),
                    Text(note.createdAt.toString(),
                        style: Theme.of(context).textTheme.subtitle2),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
