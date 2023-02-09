import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';

import '../domain/new_note_view_model.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final model = serviceLocator<NewNoteViewModel>();

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
            onPressed: (model.status == ViewState.busy)
                ? null
                : () async {
                    if (titleController.text.isEmpty ||
                        contentController.text.isEmpty) {
                      setState(() {
                        errorContent = 'You need to fill both fields';
                      });
                    } else {
                      await model.addNote(
                          titleController.text, contentController.text);

                      if (mounted && model.isNotificationShouldMeShown) {
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

                      context.router.pop();
                    }
                  },
            icon: (model.status == ViewState.busy)
                ? const Icon(
                    Icons.save_outlined,
                    color: Colors.grey,
                  )
                : const Icon(Icons.save_outlined),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: AnimatedBuilder(
              animation: model,
              builder: (context, _) {
                if (model.status == ViewState.busy) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
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
                );
              })),
    );
  }
}
