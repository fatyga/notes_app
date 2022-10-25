import 'package:flutter/material.dart';
import 'package:notes_app/components/empty_notes_info.dart';
import 'package:notes_app/components/note.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/core/database/models.dart';

class PinnedNotesTab extends StatelessWidget {
  const PinnedNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<Note>>(context)
        .where((element) => element.pinned)
        .toList();

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
