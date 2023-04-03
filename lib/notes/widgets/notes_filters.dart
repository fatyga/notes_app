import 'package:flutter/material.dart';

import '../../shared/widgets/tags.dart';
import '../domain/notes_list_view_model.dart';

enum StringFilteringOrder { ascending, descending }

enum DateFilteringOrder { oldest, newest }

class NotesFilters extends StatelessWidget {
  const NotesFilters({
    super.key,
    required this.model,
  });

  final NotesListViewModel model;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: model,
        builder: (context, _) {
          return SimpleDialog(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              insetPadding: const EdgeInsets.all(8.0),
              children: [
                Center(
                  child: Text('Filter notes',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Row(children: [
                  const Text('Title: '),
                  Wrap(
                      spacing: 4.0,
                      children: StringFilteringOrder.values
                          .map((e) => ChoiceChip(
                                label: Text(e.name),
                                selected: model.titleFilterOrder == e,
                                onSelected: (value) {
                                  model.setStringFilteringOrder(
                                      'title', value ? e : null);
                                },
                              ))
                          .toList())
                ]),
                Row(children: [
                  const Text('Date: '),
                  Wrap(
                    spacing: 4.0,
                    children: DateFilteringOrder.values
                        .map((e) => ChoiceChip(
                            label: Text(e.name),
                            selected: model.dateFilterOrder == e,
                            onSelected: (value) =>
                                model.setDateFilteringOrder(value ? e : null)))
                        .toList(),
                  )
                ]),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tags: '),
                    Expanded(
                      child: Tags(
                          availableTags: model.availableTags,
                          selectedTags: model.selectedTags,
                          onTagSelect: model.selectTag,
                          oneline: false),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      onPressed: () {
                        model.clearFilters();
                      },
                      child: const Text('CLEAR')),
                  FilledButton(
                      onPressed: () {
                        model.filterNotes();
                        Navigator.of(context).pop();
                      },
                      child: const Text('APPLY'))
                ])
              ]);
        });
  }
}
