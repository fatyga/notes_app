import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/notes_view_model.dart';
import 'package:notes_app/notes/widgets/empty_notes_info.dart';
import 'package:notes_app/notes/widgets/note.dart';
import 'package:notes_app/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes/domain/models/note.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final model = serviceLocator<NotesViewModel>();

    return AnimatedBuilder(
        animation: model,
        builder: (context, _) {
          if (model.notes.isEmpty) {
            return const EmptyNotesInfo();
          }
          return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemCount: model.notes.length,
              itemBuilder: (context, index) {
                return NoteWidget(note: model.notes[index]);
              });
        });
  }
}
