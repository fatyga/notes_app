import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NotePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Notes>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text("Edit",
                  style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(model.notes[model.currentNote].title,
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(model.notes[model.currentNote].formattedTime,
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 20),
            Text(model.notes[model.currentNote].content,
                style: TextStyle(color: Colors.grey[100], fontSize: 15))
          ],
        ),
      ),
    );
  }
}
