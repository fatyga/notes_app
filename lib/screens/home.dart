import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';
import 'package:notes_app/components/note.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Notes>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        title: Text('Notes',
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: ListView.builder(
            itemCount: context.read<Notes>().notesCount,
            itemBuilder: (context, index) {
              return NoteWidget(noteInstance: model.notes[index]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        elevation: 12,
        onPressed: () {
          context.read<Notes>().noteManipulationMode = 'new_note';
          Navigator.pushNamed(context, '/newNote');
        },
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
