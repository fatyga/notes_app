import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/notification.dart';
import '../../shared/widgets/tags.dart';
import '../notes.dart';

@RoutePage()
class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final model = serviceLocator<NewNoteViewModel>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    model.startTagsSubscription();
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
        title: const Text('Add new note'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (model.status == ViewState.busy)
                ? null
                : () async {
                    await model.addNote(
                        titleController.text, contentController.text);
                    if (mounted) {
                      showNotificationToUser(context, model, true);
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AnimatedBuilder(
            animation: model,
            builder: (context, _) {
              if (model.status == ViewState.busy) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: <Widget>[
                  Tags(
                    availableTags: model.tags,
                    selectedTags: model.selectedTags,
                    onTagSelect: model.selectTag,
                    oneline: true,
                  ),
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
            }),
      ),
    );
  }
}
