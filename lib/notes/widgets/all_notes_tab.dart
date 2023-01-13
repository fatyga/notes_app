import 'package:flutter/material.dart';
import 'package:notes_app/notes/widgets/empty_notes_info.dart';
import 'package:notes_app/notes/widgets/note.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes/domain/models/models.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<Note>>(context);
    return (notes.isEmpty)
        ? const EmptyNotesInfo()
        : ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteWidget(note: notes[index]);
            });
  }
}
