import 'package:flutter/material.dart';
import 'package:notes_app/notes/notes.dart';

import 'package:notes_app/notes/widgets/note.dart';
import 'package:notes_app/notes/domain/models/note.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes, required this.viewType});
  final List<Note> notes;
  final NotesViewType viewType;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return const EmptyNotesInfo();
    }

    if (viewType == NotesViewType.list) {
      return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 4),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteWidget(note: notes[index]);
          });
    } else {
      return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: notes.map((note) => NoteWidget(note: note)).toList());
    }
  }
}
