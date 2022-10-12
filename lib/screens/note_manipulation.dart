import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class NoteManipulation extends StatefulWidget {
  const NoteManipulation({super.key});

  @override
  _NoteManipulationState createState() => _NoteManipulationState();
}

class _NoteManipulationState extends State<NoteManipulation> {
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
    final provider = Provider.of<Notes>(context);
    final selectedNoteIndex =
        ModalRoute.of(context)!.settings.arguments as int?;

    if (selectedNoteIndex != null) {
      titleController.text = provider.notes[selectedNoteIndex].title;
      contentController.text = provider.notes[selectedNoteIndex].content;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (titleController.text.isEmpty ||
                  contentController.text.isEmpty) {
                setState(() {
                  errorContent = 'You need to fill both fields';
                });
              } else {
                if (selectedNoteIndex != null) {
                  provider.edit(selectedNoteIndex, titleController.text,
                      contentController.text);
                } else {
                  provider.add(Note(
                    dateTime: DateTime.now(),
                    title: titleController.text,
                    content: contentController.text,
                  ));
                }
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.save_outlined),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: <Widget>[
              Text(errorContent,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Theme.of(context).errorColor)),
              TextField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                decoration: const InputDecoration(hintText: ("Title")),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(hintText: ("Type here..")),
              ),
            ],
          )),
    );
  }
}
