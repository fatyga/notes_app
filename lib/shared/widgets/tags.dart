import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/models/tag.dart';
import 'package:notes_app/route/app_router.gr.dart';

class Tags extends StatelessWidget {
  const Tags(
      {super.key,
      required this.availableTags,
      required this.selectedTags,
      required this.onTagSelect,
      required this.withEditButton,
      required this.oneline});
  final List<NoteTag> availableTags;
  final List<NoteTag> selectedTags;
  final Function(NoteTag) onTagSelect;
  final bool withEditButton;
  final bool oneline;

  @override
  Widget build(BuildContext context) {
    if (oneline) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            runAlignment: WrapAlignment.start,
            spacing: 8,
            children: createChips(context),
          ));
    } else {
      return Wrap(
        spacing: 8,
        children: createChips(context),
      );
    }
  }

  List<Widget> createChips(BuildContext context) {
    final chips = availableTags
        .map<Widget>((tag) => FilterChip(
            visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
            selected: selectedTags.contains(tag),
            showCheckmark: false,
            label: Text(tag.name),
            onSelected: (_) => onTagSelect(tag)))
        .toList();
    if (withEditButton) {
      chips.add(ActionChip(
          visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
          label: const Icon(Icons.edit),
          onPressed: () {
            context.router.push(const TagsManageRoute());
          }));
    }

    return chips;
  }
}

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({super.key, required this.onTagAdd});
  final Function(String) onTagAdd;

  @override
  State<NewTagDialog> createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  final _tagNameFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add new tag'),
        content: TextField(
          controller: _tagNameFieldController,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                widget.onTagAdd(_tagNameFieldController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Add"))
        ]);
  }
}
