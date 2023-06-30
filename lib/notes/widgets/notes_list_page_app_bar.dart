import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/account/account.dart';
import 'package:notes_app/shared/dialogs.dart';
import 'package:notes_app/shared/toasts.dart';

import '../../route/app_router.gr.dart';
import '../../shared/notes_mode.dart';
import '../../shared/widgets/avatar.dart';
import '../notes.dart';

class NotesListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotesListAppBar(
      {super.key,
      required this.notesViewModel,
      required this.avatarViewModel,
      required this.changeViewType,
      required this.viewType,
      required this.showFilters});

  final NotesListViewModel notesViewModel;
  final AvatarViewModel avatarViewModel;

  final VoidCallback changeViewType;
  final NotesViewType viewType;

  final VoidCallback showFilters;

  @override
  final Size preferredSize = const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    switch (notesViewModel.currentMode) {
      case NotesListPageMode.list:
      case NotesListPageMode.filter:
        return AppBar(
          title: const Text('Notes'),
          leading: AnimatedBuilder(
              animation: avatarViewModel,
              builder: (context, _) => GestureDetector(
                    onTap: () {
                      context.router.push(const AccountRouter());
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: UserAvatar(
                        radius: 22,
                        avatarUrl: avatarViewModel.avatarUrl.isEmpty
                            ? null
                            : avatarViewModel.avatarUrl,
                      ),
                    ),
                  )),
          actions: [
            IconButton(
                tooltip: 'Search notes by phrase',
                onPressed: () =>
                    notesViewModel.enterMode(NotesListPageMode.search),
                icon: const Icon(Icons.search)),
            IconButton(
                tooltip: 'Show filters',
                onPressed: showFilters,
                icon: Icon(notesViewModel.isFiltersApplied
                    ? Icons.filter_alt_rounded
                    : Icons.filter_alt_outlined)),
            IconButton(
                tooltip: 'Change view type',
                onPressed: changeViewType,
                icon: (viewType == NotesViewType.grid)
                    ? const Icon(Icons.grid_view_outlined)
                    : const Icon(Icons.view_stream_sharp))
          ],
        );

      case NotesListPageMode.selection:
        return AppBar(
            title: const Text('Select notes'),
            leading: IconButton(
                onPressed: notesViewModel.restorePreviousMode,
                tooltip: 'Leave selection currentMode',
                icon: const Icon(Icons.close)),
            actions: [
              IconButton(
                  tooltip: 'Delete selected notes',
                  onPressed: (notesViewModel.isAnyNoteSelected)
                      ? () {
                          context.deleteDialog(() =>
                              notesViewModel.deleteNotesInSelection().then((_) {
                                context.showToast('Notes deleted!');
                              }));
                        }
                      : null,
                  icon: const Icon(Icons.delete)),
              IconButton(
                  tooltip: notesViewModel.selectAll
                      ? 'Deselect all notes'
                      : 'Select all notes',
                  onPressed: notesViewModel.batchSelecting,
                  icon: Icon(notesViewModel.selectAll
                      ? Icons.deselect
                      : Icons.select_all))
            ]);

      case NotesListPageMode.search:
        return SearchAppBar(notesViewModel: notesViewModel);
    }
  }
}

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    super.key,
    required this.notesViewModel,
  });

  final NotesListViewModel notesViewModel;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  late final TextEditingController searchController =
      TextEditingController(text: widget.notesViewModel.searchedPhrase);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: widget.notesViewModel.restorePreviousMode,
          tooltip: 'Stop searching',
          icon: const Icon(Icons.close)),
      title: TextField(
        controller: searchController,
        onChanged: widget.notesViewModel.searchNotes,
        decoration: const InputDecoration(hintText: 'Type something...'),
      ),
    );
  }
}
