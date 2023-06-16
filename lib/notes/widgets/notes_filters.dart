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
        Text('Filter by:', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        _FilteringOptions(viewModel: viewModel)
      ],
    );
  }
}

class ExpansionPanelItem {
  ExpansionPanelItem({required this.title, this.isExpanded = false});
  String title;

  bool isExpanded;
}

class _FilteringOptions extends StatefulWidget {
  const _FilteringOptions({
    super.key,
    required this.viewModel,
  });

  final NotesListViewModel viewModel;

  @override
  State<_FilteringOptions> createState() => _FilteringOptionsState();
}

class _FilteringOptionsState extends State<_FilteringOptions> {
  final List<ExpansionPanelItem> _options = [ExpansionPanelItem(title: 'Tags')];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        elevation: 0,
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            _options[panelIndex].isExpanded = !isExpanded;
          });
        },
        children: _options
            .map((item) => ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                      selected: widget.viewModel.selectedTags.isNotEmpty,
                      title: widget.viewModel.selectedTags.isNotEmpty
                          ? Text(
                              'Tags (${widget.viewModel.selectedTags.length} selected)')
                          : const Text('Tags '));
                },
                body: Tags(
                    availableTags: widget.viewModel.availableTags,
                    selectedTags: widget.viewModel.selectedTags,
                    onTagSelect: widget.viewModel.selectTag,
                    oneline: false),
                isExpanded: item.isExpanded))
            .toList());
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
