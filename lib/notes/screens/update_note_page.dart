import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/toasts.dart';
import '../../shared/widgets/tags.dart';
import '../notes.dart';

@RoutePage()
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

  bool get noteEdited =>
      titleController.text != model.note.title ||
      contentController.text != model.note.content;

  @override
  void initState() {
    model.startTagsSubscription();
    model.loadSavedNote(widget.noteId).then((_) {
      titleController.text = model.note.title;
      contentController.text = model.note.content;
    });
    super.initState();
  }

  @override
  void dispose() {
    model.stopTagsSubscription();
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
                        await model
                            .updateNote(
                          title: titleController.text,
                          content: contentController.text,
                        )
                            .then((_) {
                          context.showToast('Note updated!');
                          context.router.pop();
                        });
                        // if (mounted) {
                        //   showNotificationToUser(context, model, true);
                        // }
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
            return Form(
              onWillPop: () async {
                if (noteEdited) {
                  final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: const Text('Discard Changes?'),
                              content: const Text(
                                  'Are you sure you want to discard your changes?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      context.router.pop(false);
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      context.router.pop(true);
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .error),
                                    child: const Text('Yes'))
                              ]));
                  if (confirmed == true) {
                    return true;
                  } else {
                    return false;
                  }
                }

                return true;
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Tags(
                        availableTags: model.availableTags,
                        selectedTags: model.selectedTags,
                        onTagSelect: model.selectTag,
                        oneline: true,
                      ),
                      Text(errorContent,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.error)),
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
          }),
    );
  }
}
