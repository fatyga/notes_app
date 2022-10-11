import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NotePreview extends StatelessWidget {
  const NotePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);
    final selectedNoteIndex = ModalRoute.of(context)!.settings.arguments as int;

    final selectedNote = provider.notes[selectedNoteIndex];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/noteManipulation',
                    arguments: selectedNoteIndex);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                provider.pinUnpin(selectedNoteIndex);
              },
              icon: Icon(
                (selectedNote.isPinned)
                    ? Icons.push_pin
                    : Icons.push_pin_outlined,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              selectedNote.title,
            ),
            const SizedBox(height: 20),
            Text(
              selectedNote.createdAt,
            ),
            const SizedBox(height: 20),
            Text(
              selectedNote.content,
            )
          ],
        ),
      ),
    );
  }
}
