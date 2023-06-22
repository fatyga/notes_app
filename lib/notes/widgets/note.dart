import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/route/app_router.gr.dart';

import '../../shared/notes_mode.dart';
import '../notes.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget(
      {super.key,
      required this.note,
      required this.notesMode,
      required this.onNoteSelect,
      required this.onEnterSelectionMode,
      required this.inSelection,
      this.searchedPhrase});

  final Note note;

  final NotesMode notesMode;
  final bool inSelection;
  final Function(Note) onNoteSelect;
  final VoidCallback onEnterSelectionMode;

  final String? searchedPhrase;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[100],
      /* TODO: replace static color */
      clipBehavior: Clip.hardEdge,
      child: IntrinsicHeight(
        /* maybe bad influence to performance */
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: _NoteHeader(
                      note: note,
                      selectionMode: notesMode.isSelection,
                      onNoteSelect: () => onNoteSelect(note),
                      onEnterSelectionMode: onEnterSelectionMode)),
              _NoteFooter(
                note: note,
                inSelection: inSelection,
                selectionMode: notesMode.isSelection,
                onNoteSelect: () => onNoteSelect(note),
              )
            ]),
      ),
    );
  }
}

class _NoteHeader extends StatelessWidget {
  const _NoteHeader(
      {required this.note,
      required this.selectionMode,
      required this.onNoteSelect,
      required this.onEnterSelectionMode});

  final Note note;

  final bool selectionMode;
  final VoidCallback onNoteSelect;
  final VoidCallback onEnterSelectionMode;

  Widget _showNoteContentIfPossible(BuildContext context) {
    if (note.title.length <= 30 && note.content.isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(note.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black54)));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onLongPress: selectionMode
              ? null
              : () {
                  onEnterSelectionMode();
                  onNoteSelect();
                },
          onTap: () {
            if (selectionMode) {
              onNoteSelect();
            } else {
              context.router.push(NotePreviewRoute(noteId: note.id));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.titleLarge),
                _showNoteContentIfPossible(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NoteFooter extends StatelessWidget {
  const _NoteFooter(
      {required this.note,
      required this.onNoteSelect,
      required this.selectionMode,
      required this.inSelection});
  final Note note;

  final bool selectionMode;
  final bool inSelection;
  final VoidCallback onNoteSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(note.formattedTime,
              style: Theme.of(context).textTheme.titleSmall),
        ),
        selectionMode
            ? SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                    onChanged: (_) => onNoteSelect(), value: inSelection))
            : InkWell(onTap: () {}, child: const Icon(Icons.more_horiz))
      ]),
    );
  }
}
