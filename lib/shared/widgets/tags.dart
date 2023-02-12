import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags(
      {super.key,
      required this.availableTags,
      required this.selectedTags,
      required this.onTagSelect,
      this.onTagAdd});
  final List<String> availableTags;
  final List<String> selectedTags;
  final Function(String) onTagSelect;
  final Function(String)? onTagAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          const Text('Tags: '),
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 4,
                  children: createChips(context),
                )),
          ),
        ],
      ),
    );
  }

  List<Widget> createChips(BuildContext context) {
    final chips = availableTags
        .map<Widget>((tagName) => FilterChip(
            selected: selectedTags.contains(tagName),
            showCheckmark: false,
            label: Text(tagName),
            onSelected: (_) => onTagSelect(tagName)))
        .toList();

    if (onTagAdd != null) {
      chips.add(ActionChip(
          label: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => NewTagDialog(
                      onTagAdd: onTagAdd!,
                    ));
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
