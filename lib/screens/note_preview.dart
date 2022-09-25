import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NotePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Notes>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('notes'),
      ),
      body: Column(
        children: <Widget>[
          Text(model.notes[model.currentNote].formattedTime),
          Text(model.notes[model.currentNote].title),
          Text(model.notes[model.currentNote].content)
        ],
      ),
    );
  }
}
