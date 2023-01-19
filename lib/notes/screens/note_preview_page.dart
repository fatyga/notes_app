import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/service_locator.dart';

import '../domain/notes_preview_view_model.dart';

class NotePreviewPage extends StatefulWidget {
  const NotePreviewPage({super.key, required this.noteId});
  final String noteId;

  @override
  State<NotePreviewPage> createState() => _NotePreviewPageState();
}

class _NotePreviewPageState extends State<NotePreviewPage> {
  final model = serviceLocator<NotesPreviewViewModel>();

  @override
  void initState() {
    model.startNoteChangeSubscription(widget.noteId);
    super.initState();
  }

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
                      //await model.deleteNote();
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
                    if (model.status == ModelStatus.busy) {
                      return CircularProgressIndicator();
                    }
                    return IconButton(
                        onPressed: () async {
                          //await model.updateNote(changePinned: true);
                        },
                        icon: model.note!.pinned
                            ? const Icon(Icons.push_pin_rounded)
                            : const Icon(
                                Icons.push_pin_outlined,
                              ));
                  },
                ),
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: AnimatedBuilder(
          animation: model,
          builder: (context, child) {
            if (model.status == ModelStatus.busy) {
              return const Center(child: CircularProgressIndicator());
            }

            if (model.note == null) {
              return Container();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.note!.title,
                    style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: 20),
                Text(model.note!.formattedTime,
                    style: Theme.of(context).textTheme.subtitle2),
                const SizedBox(height: 20),
                Text(model.note!.content,
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            );
          },
        ),
      ),
    );
  }
}
