import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';

import '../domain/note_update_view_model.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key, required this.noteId});
  final String noteId;

  @override
  _UpdateNotePageState createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final model = serviceLocator<NoteUpdateViewModel>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String errorContent = '';

  @override
  void initState() {
    model.loadSavedNote(widget.noteId).then((_) {
      titleController.text = model.note.title;
      contentController.text = model.note.content;
    });
    super.initState();
  }

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
          AnimatedBuilder(
              animation: model,
              builder: (context, _) {
                if (model.status == ViewState.busy) {
                  return Row();
                }

                return Row(children: [
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
                        );
                        context.router.pop();
                      }
                    },
                    icon: const Icon(Icons.save_outlined),
                  )
                ]);
              })
        ],
      ),
      body: AnimatedBuilder(
          animation: model,
          builder: (context, _) {
            if (model.status == ViewState.busy) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                ));
          }),
    );
  }
}
