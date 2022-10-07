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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/noteManipulation',
                    arguments: selectedNoteIndex);
              },
              child: Text("Edit",
                  style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
          TextButton(
              onPressed: () {
                provider.pinUnpin(selectedNoteIndex);
              },
              child: Text((selectedNote.isPinned) ? "Unpin" : "Pin",
                  style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(selectedNote.title,
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(selectedNote.createdAt,
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 20),
            Text(selectedNote.content,
                style: TextStyle(color: Colors.grey[100], fontSize: 15))
          ],
        ),
      ),
    );
  }
}
