import 'package:flutter/material.dart';
import 'package:notes_app/components/empty_notes_info.dart';
import 'package:notes_app/components/note.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);
    return (provider.notes.isEmpty)
        ? const EmptyNotesInfo()
        : ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              return NoteWidget(noteInstance: provider.notes[index]);
            });
  }
}
