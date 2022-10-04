import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NotePreview extends StatelessWidget {
  const NotePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Notes>(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                context.read<Notes>().noteManipulationMode = 'edit_note';
                Navigator.pushNamed(context, '/newNote');
              },
              child: Text("Edit",
                  style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: model.selectedNote == null
            ? const Text('no data')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.selectedNote!.title,
                      style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(model.selectedNote!.formattedTime,
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 20),
                  Text(model.selectedNote!.content,
                      style: TextStyle(color: Colors.grey[100], fontSize: 15))
                ],
              ),
      ),
    );
  }
}
