import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import '../../route/app_router.gr.dart';
import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/toasts.dart';
import '../notes.dart';

@RoutePage()
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
                        await model.deleteNote(widget.noteId).then((_) {
                          context.showToast('Note deleted!');
                          context.router.pop();
                        });
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
                        await model.pinUnpinNote().then((_) {
                          context.showToast(model.isNotePinned
                              ? 'Note pinned!'
                              : 'Note unpinned!');
                        });
                      },
                      icon: model.isNoteContainTag('pinned')
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
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 20),
                Row(
                    children: model.note.tags.isEmpty
                        ? []
                        : [
                            const Text('Tags:'),
                            Text(model.getTagsNames().join(','))
                          ]),
                Text(model.note.formattedTime,
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 20),
                Text(model.note.content,
                    style: Theme.of(context).textTheme.bodyLarge)
              ],
            );
          },
        ),
      ),
    );
  }
}
