import 'package:flutter/material.dart';

import '../notes.dart';

class NotesList extends StatelessWidget {
  const NotesList(
      {super.key,
      required this.notes,
      required this.notesInSelection,
      required this.viewType,
      required this.selectionMode,
      required this.onNoteSelect,
      required this.onEnterSelectionMode});

  final List<Note> notes;
  final NotesViewType viewType;

  final bool selectionMode;
  final List<Note> notesInSelection;
  final Function(Note) onNoteSelect;
  final VoidCallback onEnterSelectionMode;

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
            return NoteWidget(
              note: notes[index],
              selectionMode: selectionMode,
              inSelection: notesInSelection.contains(notes[index]),
              onNoteSelect: onNoteSelect,
              onEnterSelectionMode: onEnterSelectionMode,
            );
          });
    } else {
      return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: notes
              .map((note) => NoteWidget(
                    note: note,
                    selectionMode: selectionMode,
                    inSelection: notesInSelection.contains(note),
                    onNoteSelect: onNoteSelect,
                    onEnterSelectionMode: onEnterSelectionMode,
                  ))
              .toList());
    }
  }
}
