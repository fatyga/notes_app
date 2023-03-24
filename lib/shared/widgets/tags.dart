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
      required this.oneline});
  final List<NoteTag> availableTags;
  final List<String> selectedTags;
  final Function(String) onTagSelect;

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
            selected: selectedTags.contains(tag.id),
            showCheckmark: false,
            label: Text(tag.name),
            onSelected: (_) => onTagSelect(tag.id)))
        .toList();

    return chips;
  }
}
