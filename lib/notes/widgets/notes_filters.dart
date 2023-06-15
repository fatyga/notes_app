import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/tags.dart';
import '../notes.dart';

class NotesFilters extends StatelessWidget {
  const NotesFilters({
    super.key,
    required this.viewModel,
  });

  final NotesListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Text('Filters', style: Theme.of(context).textTheme.titleLarge),
              Expanded(
                  child: _Filters(
                viewModel: viewModel,
              )),
              _Buttons(
                  onFiltersApply: viewModel.applyFilters,
                  onFiltersClear: viewModel.clearFilters)
            ]),
          );
        });
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    super.key,
    required this.viewModel,
  });

  final NotesListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sort by:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(width: 8),
            DropdownButton<SortingOption>(
                value: viewModel.chosenSortingOption,
                items: SortingOption.values
                    .map<DropdownMenuItem<SortingOption>>((option) =>
                        DropdownMenuItem(
                            value: option, child: Text(option.displayName)))
                    .toList(),
                onChanged: viewModel.changeSortingOption),
          ],
        ),
        // ExpansionTile(
        //     leading: Checkbox(
        //       value: true,
        //       onChanged: (value) {},
        //     ),
        //     title: const Text('Tags'),
        //     children: [
        //       Tags(
        //           availableTags: viewModel.availableTags,
        //           selectedTags: viewModel.selectedTags,
        //           onTagSelect: viewModel.selectTag,
        //           oneline: false),
        //     ]),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    super.key,
    required this.onFiltersClear,
    required this.onFiltersApply,
  });

  final VoidCallback onFiltersClear;
  final VoidCallback onFiltersApply;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Expanded(
        child: ElevatedButton(
            onPressed: onFiltersClear, child: const Text('CLEAR')),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: FilledButton(
            onPressed: () {
              onFiltersApply();
              context.router.pop();
            },
            child: const Text('APPLY')),
      )
    ]);
  }
}
