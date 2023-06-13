import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:notes_app/account/account.dart';
import 'package:notes_app/shared/dialogs.dart';
import 'package:notes_app/shared/toasts.dart';

import '../../route/app_router.gr.dart';
import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/widgets/avatar.dart';
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
        builder: (context) => NotesFilters(model: notesViewModel));
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
              appBar: AppBar(
                title: Text(notesViewModel.selectionModeEnabled
                    ? 'Select notes'
                    : 'Notes'),
                centerTitle: true,
                leading: (notesViewModel.selectionModeEnabled)
                    ? IconButton(
                        onPressed: notesViewModel.leaveSelectionMode,
                        icon: const Icon(Icons.close))
                    : AnimatedBuilder(
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
                actions: (notesViewModel.selectionModeEnabled)
                    ? [
                        IconButton(
                            onPressed: (notesViewModel.isAnyNoteSelected)
                                ? () {
                                    context.deleteDialog(() => notesViewModel
                                            .deleteNotesInSelection()
                                            .then((_) {
                                          context.showToast('Notes deleted!');
                                        }));
                                  }
                                : null,
                            icon: const Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              notesViewModel.batchSelecting();
                            },
                            icon: Icon(notesViewModel.selectAll
                                ? Icons.deselect
                                : Icons.select_all))
                      ]
                    : [
                        IconButton(
                            onPressed: () => _showFilters(),
                            icon: const Icon(Icons.filter_alt_rounded)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                currentNotesViewType =
                                    currentNotesViewType == NotesViewType.grid
                                        ? NotesViewType.list
                                        : NotesViewType.grid;
                              });
                            },
                            icon: (currentNotesViewType == NotesViewType.grid)
                                ? const Icon(Icons.grid_view_outlined)
                                : const Icon(Icons.view_stream_sharp))
                      ],
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
                                    selectionMode:
                                        notesViewModel.selectionModeEnabled,
                                    notesInSelection:
                                        notesViewModel.notesInSelection,
                                    viewType: currentNotesViewType,
                                    onNoteSelect:
                                        notesViewModel.switchNoteSelection,
                                    onEnterSelectionMode:
                                        notesViewModel.enterSelectionMode,
                                  )),
                            ),
                          ],
                        ),
                        if (notesViewModel.isFiltersApplied)
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
              floatingActionButton: notesViewModel.selectionModeEnabled
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
