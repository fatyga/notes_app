import 'package:flutter/material.dart';
import 'package:notes_app/components/empty_notes_info.dart';
import 'package:notes_app/components/note.dart';
import 'package:notes_app/notes.dart';
import 'package:provider/provider.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Notes>(context);
    return model.notes.isEmpty
        ? const EmptyNotesInfo()
        : ListView.builder(
            itemCount: model.notes.length,
            itemBuilder: (ctx, i) => NoteWidget(
              noteInstance: model.notes[i],
            ),
          );
  }
}
