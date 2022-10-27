import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/database/firestore_service.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:provider/provider.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key, required this.selectedNoteId});

  final String selectedNoteId;

  @override
  _UpdateNotePageState createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String errorContent = '';
  bool filledInputs = false;
  bool loading = false;

  final db = FirestoreService();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final selectedNote = Provider.of<List<Note>>(context)
        .firstWhere((element) => element.id == widget.selectedNoteId);

    if (!filledInputs) {
      titleController.text = selectedNote.title;
      contentController.text = selectedNote.content;
      filledInputs = true;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !loading,
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
                await db.updateNote(user!, selectedNote, {
                  'title': titleController.text,
                  'content': contentController.text,
                });
                context.router.pop();
              }
            },
            icon: loading
                ? const Icon(
                    Icons.save_outlined,
                    color: Colors.grey,
                  )
                : const Icon(Icons.save_outlined),
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
