import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:notes_app/account/account.dart';
import 'package:notes_app/notes/widgets/notes_list_page_app_bar.dart';
import 'package:notes_app/shared/notes_mode.dart';

import '../../route/app_router.gr.dart';
import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';

import '../notes.dart';

enum NotesViewType { grid, list }

@RoutePage()
class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final modelsWrapper = serviceLocator<NotesListWrapperViewModel>();

  NotesListViewModel get notesViewModel => modelsWrapper.notes;
  AvatarViewModel get avatarViewModel => modelsWrapper.avatar;

  NotesViewType currentNotesViewType = NotesViewType.list;

  final _fabKey = GlobalKey<ExpandableFabState>();

  void _showFilters() {
    showModalBottomSheet(
        context: context,
        builder: (context) => NotesFilters(viewModel: notesViewModel));
  }

  void changeViewType() {
    setState(() {
      currentNotesViewType = currentNotesViewType == NotesViewType.grid
          ? NotesViewType.list
          : NotesViewType.grid;
    });
  }

  @override
  void initState() {
    modelsWrapper.startSubscriptions();
    super.initState();
  }

  @override
  void dispose() {
    modelsWrapper.stopSubscriptions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: notesViewModel,
        builder: (context, _) {
          return Scaffold(
              appBar: NotesListAppBar(
                notesViewModel: notesViewModel,
                avatarViewModel: avatarViewModel,
                changeViewType: changeViewType,
                viewType: currentNotesViewType,
                showFilters: _showFilters,
              ),
              body: (notesViewModel.status == ViewState.busy)
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: NotesList(
                                    notes: notesViewModel.notesToDisplay,
                                    notesMode: notesViewModel.mode,
                                    viewType: currentNotesViewType,
                                    onNoteSelect:
                                        notesViewModel.switchNoteSelection,
                                    onEnterSelectionMode:
                                        notesViewModel.enterSelectionMode,
                                    notesInSelection:
                                        notesViewModel.notesInSelection,
                                    searchedPhrase:
                                        notesViewModel.searchedPhrase,
                                  )),
                            ),
                          ],
                        ),
                        if (notesViewModel.isFiltersApplied &&
                            notesViewModel.mode == NotesMode.filter)
                          Positioned.fill(
                            bottom: 16,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FilledButton(
                                  onPressed: () =>
                                      notesViewModel.clearFilters(),
                                  child: const Text('Clear filters')),
                            ),
                          )
                      ],
                    ),
              floatingActionButtonLocation: ExpandableFab.location,
              floatingActionButton: !notesViewModel.mode.isList
                  ? null
                  : ExpandableFab(
                      key: _fabKey,
                      overlayStyle: ExpandableFabOverlayStyle(blur: 2.0),
                      type: ExpandableFabType.up,
                      children: [
                          FloatingActionButton(
                            heroTag: null,
                            onPressed: () {
                              context.router.push(const NewNoteRoute());
                              _fabKey.currentState?.toggle();
                            },
                            child: const Icon(Icons.note_add, size: 28),
                          ),
                          FloatingActionButton(
                              heroTag: null,
                              onPressed: () {
                                _fabKey.currentState?.toggle();
                                context.router.push(const TagsManageRoute());
                              },
                              child: const Icon(Icons.collections_bookmark,
                                  size: 28)),
                        ]));
        });
  }
}
