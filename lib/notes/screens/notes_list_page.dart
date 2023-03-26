import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/notes/domain/notes_list_view_model.dart';
import 'package:notes_app/notes/widgets/notes_list.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/widgets/avatar.dart';

import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/widgets/tags.dart';
import 'package:provider/provider.dart';

enum NotesViewType { grid, list }

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final model = serviceLocator<NotesListViewModel>();
  NotesViewType currentNotesViewType = NotesViewType.list;

  final _FabKey = GlobalKey<ExpandableFabState>();

  void _showFilters() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              insetPadding: const EdgeInsets.all(8.0),
              children: [
                Center(
                  child: Text('Filter notes',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: model,
                  builder: (context, _) => Tags(
                      availableTags: model.availableTags,
                      selectedTags: model.selectedTags,
                      onTagSelect: model.selectTag,
                      oneline: false),
                ),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      onPressed: () {
                        model.clearFilters();
                      },
                      child: const Text('CLEAR')),
                  ElevatedButton(
                      onPressed: () {
                        model.filterNotes();
                        Navigator.of(context).pop();
                      },
                      child: const Text('APPLY'))
                ])
              ]);
        });
  }

  @override
  void initState() {
    model.startNotesSubscription();
    super.initState();
  }

  @override
  void dispose() {
    model.stopNotesSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          centerTitle: true,
          leading: AnimatedBuilder(
              animation: model.avatarViewModel,
              builder: (context, _) => GestureDetector(
                    onTap: () {
                      context.router.push(const UserAccountWrapperRoute());
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: UserAvatar(
                        radius: 22,
                        avatarUrl: model.avatarViewModel.avatarUrl.isEmpty
                            ? null
                            : model.avatarViewModel.avatarUrl,
                      ),
                    ),
                  )),
          actions: [
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
        body: AnimatedBuilder(
            animation: model,
            builder: (context, _) {
              if (model.status == ViewState.busy) {
                return const Center(child: CircularProgressIndicator());
              }

              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 16.0, right: 16.0),
                            child: NotesList(
                                notes: model.notesToDisplay,
                                viewType: currentNotesViewType)),
                      ),
                    ],
                  ),
                  (model.isFiltersApplied)
                      ? Positioned.fill(
                          bottom: 20,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                                onPressed: () => model.clearFilters(),
                                child: const Text('Clear filters')),
                          ),
                        )
                      : Container()
                ],
              );
            }),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
            overlayStyle: ExpandableFabOverlayStyle(blur: 2.0),
            type: ExpandableFabType.up,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _FabKey.currentState?.toggle();
                  context.router.push(const NewNoteRoute());
                },
                child: const Icon(Icons.note_add, size: 28),
              ),
              FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    _FabKey.currentState?.toggle();
                    context.router.push(const TagsManageRoute());
                  },
                  child: const Icon(Icons.collections_bookmark, size: 28)),
            ]));
  }
}
