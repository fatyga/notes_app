import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/database/db.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:provider/provider.dart';

class NoteManipulationPage extends StatefulWidget {
  const NoteManipulationPage({super.key, required this.selectedNote});

  final Note? selectedNote;

  @override
  _NoteManipulationState createState() => _NoteManipulationState();
}

class _NoteManipulationState extends State<NoteManipulationPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String errorContent = '';
  bool loading = false;

  final db = DatabaseService();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedNote != null) {
      titleController.text = widget.selectedNote!.title;
      contentController.text = widget.selectedNote!.content;
    }

    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  contentController.text.isEmpty) {
                setState(() {
                  errorContent = 'You need to fill both fields';
                });
              } else {
                setState(() {
                  loading = true;
                });
                if (widget.selectedNote == null) {
                  await db.addNote(user!, {
                    'title': titleController.text,
                    'content': contentController.text,
                    'pinned': false,
                    'createdAt': Timestamp.now()
                  });
                } else {
                  await db.updateNote(user!, widget.selectedNote!, {
                    'title': titleController.text,
                    'content': contentController.text,
                  });
                }
                context.router.pop();
              }
            },
            icon: const Icon(Icons.save_outlined),
          )
        ],
      ),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                    decoration:
                        const InputDecoration(hintText: ("Type here..")),
                  ),
                ],
              )),
    );
  }
}
