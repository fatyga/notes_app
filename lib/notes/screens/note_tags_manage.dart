import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/tags_manage_view_model.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/widgets/tags.dart';

class TagsManagePage extends StatefulWidget {
  const TagsManagePage({super.key});

  @override
  State<TagsManagePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TagsManagePage> {
  final TagsManageViewModel tagsViewModel =
      serviceLocator<TagsManageViewModel>();
  final _tagNameTextFieldController = TextEditingController();

  @override
  void initState() {
    tagsViewModel.startTagsSubscription();
    super.initState();
  }

  @override
  void dispose() {
    tagsViewModel.stopTagsSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage your tags'),
          actions: [
            IconButton(
                onPressed: () async {
                  await tagsViewModel.updateTags();
                  context.router.pop();
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: AnimatedBuilder(
          animation: tagsViewModel,
          builder: (context, child) {
            if (tagsViewModel.status == ViewState.busy) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _tagNameTextFieldController
                          ..text = tagsViewModel.selectedTag != null
                              ? tagsViewModel.selectedTag!.name
                              : '',
                        decoration: const InputDecoration(hintText: 'Name'),
                      ),
                      const SizedBox(height: 8),
                      Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (tagsViewModel.selectedTag != null) {
                                  tagsViewModel.updateTag(
                                      _tagNameTextFieldController.text);
                                  _tagNameTextFieldController.clear();
                                } else {
                                  tagsViewModel
                                      .addTag(_tagNameTextFieldController.text);
                                }
                              },
                              child: (tagsViewModel.selectedTag == null)
                                  ? const Text('Add')
                                  : const Text('Update'))),
                      const SizedBox(height: 8.0),
                      Text('All Tags',
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8.0),
                      Tags(
                          availableTags: tagsViewModel.tags,
                          withEditButton: false,
                          oneline: false,
                          selectedTags: tagsViewModel.selectedTag == null
                              ? []
                              : [tagsViewModel.selectedTag!],
                          onTagSelect: tagsViewModel.selectTag)
                    ]));
          },
        ));
  }
}
