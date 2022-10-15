import 'package:flutter/material.dart';
import 'package:notes_app/components/empty_notes_info.dart';
import 'package:notes_app/components/note.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class PinnedNotesTab extends StatelessWidget {
  const PinnedNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);
    final pinnedNotes = provider.notes.where((note) => note.isPinned).toList();
    return (pinnedNotes.isEmpty)
        ? const EmptyNotesInfo()
        : ListView.builder(
            itemCount: pinnedNotes.length,
            itemBuilder: (context, index) {
              return NoteWidget(noteIndex: index);
            });
  }
}
