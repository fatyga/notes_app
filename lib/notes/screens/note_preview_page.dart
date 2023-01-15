import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/notes_view_model.dart';

import 'package:notes_app/notes/services/notes_service.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/service_locator.dart';
import 'package:provider/provider.dart';

class NotePreviewPage extends StatefulWidget {
  const NotePreviewPage({super.key});

  @override
  State<NotePreviewPage> createState() => _NotePreviewPageState();
}

class _NotePreviewPageState extends State<NotePreviewPage> {
  final model = serviceLocator<NotesViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: model.status == ModelStatus.busy
            ? []
            : [
                IconButton(
                    onPressed: () async {
                      await model.deleteNote();
                      context.router.pop();
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      context.router.push(const UpdateNoteRoute());
                    },
                    icon: const Icon(Icons.edit)),
                AnimatedBuilder(
                  animation: model,
                  builder: (context, _) {
                    return IconButton(
                        onPressed: () async {
                          await model.updateNote(changePinned: true);
                        },
                        icon: model.selectedNote!.pinned
                            ? const Icon(Icons.push_pin_rounded)
                            : const Icon(
                                Icons.push_pin_outlined,
                              ));
                  },
                ),
              ],
      ),
      body: model.status == ModelStatus.busy
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: AnimatedBuilder(
                animation: model,
                builder: (context, child) {
                  if (model.selectedNote == null) {
                    return Container();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.selectedNote!.title,
                          style: Theme.of(context).textTheme.headline5),
                      const SizedBox(height: 20),
                      Text(model.selectedNote!.formattedTime,
                          style: Theme.of(context).textTheme.subtitle2),
                      const SizedBox(height: 20),
                      Text(model.selectedNote!.content,
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  );
                },
              ),
            ),
    );
  }
}
