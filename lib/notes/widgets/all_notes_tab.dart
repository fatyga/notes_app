import 'package:flutter/material.dart';

import 'package:notes_app/notes/widgets/empty_notes_info.dart';
import 'package:notes_app/notes/widgets/note.dart';
import 'package:notes_app/notes/domain/models/note.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return const EmptyNotesInfo();
    }
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteWidget(note: notes[index]);
        });
  }
}
