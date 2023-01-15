import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/notes_view_model.dart';
import 'package:notes_app/notes/services/notes_service.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/service_locator.dart';
import 'package:provider/provider.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key});

  @override
  _UpdateNotePageState createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final model = serviceLocator<NotesViewModel>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String errorContent = '';
  bool filledInputs = false;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!filledInputs) {
      titleController.text = model.selectedNote!.title;
      contentController.text = model.selectedNote!.content;
      filledInputs = true;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: model.status == ModelStatus.busy,
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
                await model.updateNote(
                    title: titleController.text,
                    content: contentController.text,
                    changePinned: false);

                context.router.pop();
              }
            },
            icon: model.status == ModelStatus.busy
                ? const Icon(
                    Icons.save_outlined,
                    color: Colors.grey,
                  )
                : const Icon(Icons.save_outlined),
          )
        ],
      ),
      body: model.status == ModelStatus.busy
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
