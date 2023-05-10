import 'package:flutter/material.dart';

import '../../shared/widgets/tags.dart';
import '../notes.dart';

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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Center(
                child: Text('Filter notes',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              const SizedBox(height: 16),
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
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        model.clearFilters();
                      },
                      child: const Text('CLEAR')),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                      onPressed: () {
                        model.filterNotes();
                        Navigator.of(context).pop();
                      },
                      child: const Text('APPLY')),
                )
              ])
            ]),
          );
        });
  }
}
