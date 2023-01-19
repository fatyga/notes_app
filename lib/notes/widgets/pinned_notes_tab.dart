import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/notes_view_model.dart';
import 'package:notes_app/notes/widgets/empty_notes_info.dart';
import 'package:notes_app/notes/widgets/note.dart';
import 'package:notes_app/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes/domain/models/note.dart';

class PinnedNotesTab extends StatelessWidget {
  const PinnedNotesTab({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return EmptyNotesInfo();
    }
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteWidget(note: notes[index]);
        });
  }
}
