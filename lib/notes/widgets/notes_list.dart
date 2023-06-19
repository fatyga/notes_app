import 'package:flutter/material.dart';

import '../../shared/notes_mode.dart';
import '../notes.dart';

class NotesList extends StatelessWidget {
  const NotesList(
      {super.key,
      required this.notes,
      required this.notesInSelection,
      required this.viewType,
      required this.notesMode,
      required this.onNoteSelect,
      required this.onEnterSelectionMode,
      this.searchedPhrase});

  final List<Note> notes;
  final NotesViewType viewType;
  final Function(Note) onNoteSelect;

  final NotesMode notesMode;

  final List<Note> notesInSelection;
  final VoidCallback onEnterSelectionMode;

  final String? searchedPhrase;
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
              notesMode: notesMode,
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
                    notesMode: notesMode,
                    inSelection: notesInSelection.contains(note),
                    onNoteSelect: onNoteSelect,
                    onEnterSelectionMode: onEnterSelectionMode,
                  ))
              .toList());
    }
  }
}
