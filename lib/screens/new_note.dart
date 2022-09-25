import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              var model = context.read<Notes>();

              model.add(Note(
                time: DateTime.now(),
                title: titleController.text,
                content: contentController.text,
              ));
              Navigator.pop(context);
            },
            child: Text("Save",
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.grey[100],
                decoration: InputDecoration(
                    hintText: ("Title"),
                    hintStyle: TextStyle(fontSize: 30, color: Colors.grey),
                    border: InputBorder.none),
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(height: 20),
              TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.grey[100],
                decoration: InputDecoration(
                    hintText: ("Type here.."),
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          )),
    );
  }
}