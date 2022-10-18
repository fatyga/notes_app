import 'package:flutter/material.dart';
import 'package:notes_app/components/empty_notes_info.dart';
import 'package:notes_app/components/note.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/core/database/models.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<Note>>(context);

    return (notes.isEmpty)
        ? const EmptyNotesInfo()
        : ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteWidget(note: notes[index]);
            });
  }
}
