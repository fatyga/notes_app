import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/notes/domain/models/note.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[100],
      /* TODO: replace static color */
      clipBehavior: Clip.hardEdge,
      child: IntrinsicHeight(
        /* maybe bad influence to performance */
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: _NoteHeader(note)),
              _NoteFooter(note)
            ]),
      ),
    );
  }
}

class _NoteHeader extends StatelessWidget {
  const _NoteHeader(this.note, {super.key});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            context.router.push(NotePreviewRoute(noteId: note.id));
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(note.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
      ),
    );
  }
}

class _NoteFooter extends StatelessWidget {
  const _NoteFooter(this.note, {super.key});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(note.formattedTime, style: Theme.of(context).textTheme.subtitle2),
        InkWell(onTap: () {}, child: const Icon(Icons.more_horiz))
      ]),
    );
  }
}
