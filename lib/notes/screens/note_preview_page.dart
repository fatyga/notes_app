import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';

import '../domain/note_preview_view_model.dart';

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
  void dispose() {
    model.stopNoteChangeSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          AnimatedBuilder(
              animation: model,
              builder: (context, child) {
                if (model.status == ViewState.busy) {
                  return Row();
                }

                return Row(children: [
                  IconButton(
                      onPressed: () async {
                        await model.deleteNote(widget.noteId);
                        if (mounted && model.isNotificationShouldMeShown) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(model.userNotification.content),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }

                        context.router.pop();
                      },
                      icon: const Icon(Icons.delete)),
                  IconButton(
                      onPressed: () {
                        context.router
                            .push(UpdateNoteRoute(noteId: widget.noteId));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await model.pinUnpinNote();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: model.userNotification.isError
                                  ? Theme.of(context).errorColor
                                  : null,
                              content: Text(model.userNotification.content),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      icon: model.note.pinned
                          ? const Icon(Icons.push_pin_rounded)
                          : const Icon(
                              Icons.push_pin_outlined,
                            ))
                ]);
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: AnimatedBuilder(
          animation: model,
          builder: (context, child) {
            if (model.status == ViewState.busy) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.note.title,
                    style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: 20),
                Text(model.note.formattedTime,
                    style: Theme.of(context).textTheme.subtitle2),
                const SizedBox(height: 20),
                Text(model.note.content,
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            );
          },
        ),
      ),
    );
  }
}
