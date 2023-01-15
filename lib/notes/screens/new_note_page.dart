import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/notes_view_model.dart';
import 'package:notes_app/notes/services/notes_service.dart';
import 'package:notes_app/service_locator.dart';
import 'package:provider/provider.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final model = serviceLocator<NotesViewModel>();

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (model.status == ModelStatus.busy)
                ? null
                : () async {
                    if (titleController.text.isEmpty ||
                        contentController.text.isEmpty) {
                      setState(() {
                        errorContent = 'You need to fill both fields';
                      });
                    } else {
                      model.addNote(
                          titleController.text, contentController.text);

                      context.router.pop();
                    }
                  },
            icon: (model.status == ModelStatus.busy)
                ? const Icon(
                    Icons.save_outlined,
                    color: Colors.grey,
                  )
                : const Icon(Icons.save_outlined),
          )
        ],
      ),
      body: (model.status == ModelStatus.busy)
          ? const Center(child: CircularProgressIndicator())
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
