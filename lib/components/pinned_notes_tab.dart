import 'package:flutter/material.dart';
import 'package:notes_app/components/empty_notes_info.dart';
import 'package:notes_app/components/note.dart';
import 'package:notes_app/notes.dart';
import 'package:provider/provider.dart';

class PinnedNotesTab extends StatelessWidget {
  const PinnedNotesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Notes>(context);
    final pinnedNotes = model.notes.where((note) => note.isPinned).toList();
    return pinnedNotes.isEmpty
        ? const EmptyNotesInfo()
        : ListView.builder(
            itemCount: pinnedNotes.length,
            itemBuilder: (ctx, i) => NoteWidget(
              noteInstance: pinnedNotes[i],
            ),
          );
  }
}
