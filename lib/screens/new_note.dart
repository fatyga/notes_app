import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String errorContent = '';

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as Note?;
    final provider = Provider.of<Notes>(context);

    titleController.text = model?.title ?? '';
    contentController.text = model?.content ?? '';

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              if (titleController.text.isEmpty ||
                  contentController.text.isEmpty) {
                setState(() {
                  errorContent = 'You need to fill both fields';
                });
              } else {
                if (model != null) {
                  provider.edit(
                    model,
                    model.copyWith(
                      title: titleController.text,
                      content: contentController.text,
                    ),
                  );
                } else {
                  provider.add(
                    Note(
                      dateTime: DateTime.now(),
                      title: titleController.text,
                      content: contentController.text,
                    ),
                  );
                }
                Navigator.pop(context);
              }
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
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: <Widget>[
              Text(errorContent, style: const TextStyle(color: Colors.red)),
              TextField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                cursorColor: Colors.grey[100],
                decoration: const InputDecoration(
                    hintText: ("Title"),
                    hintStyle: TextStyle(fontSize: 30, color: Colors.grey),
                    border: InputBorder.none),
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.grey[100],
                decoration: const InputDecoration(
                    hintText: ("Type here.."),
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          )),
    );
  }
}
