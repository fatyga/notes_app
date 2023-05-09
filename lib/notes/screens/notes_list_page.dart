import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:notes_app/notes/domain/notes_list_wrapper_view_model.dart';
import 'package:notes_app/notes/domain/notes_list_view_model.dart';
import 'package:notes_app/notes/widgets/notes_list.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/widgets/avatar.dart';

import 'package:notes_app/route/app_router.gr.dart';
import 'package:notes_app/shared/enums/view_state.dart';

import '../widgets/notes_filters.dart';

enum NotesViewType { grid, list }

@RoutePage()
class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final modelsWrapper = serviceLocator<NotesListWrapperViewModel>();
  NotesViewType currentNotesViewType = NotesViewType.list;

  final _fabKey = GlobalKey<ExpandableFabState>();

  void _showFilters() {
    showModalBottomSheet(
        context: context,
        builder: (context) => NotesFilters(model: modelsWrapper.notes));
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          centerTitle: true,
          leading: AnimatedBuilder(
              animation: modelsWrapper.avatar,
              builder: (context, _) => GestureDetector(
                    onTap: () {
                      context.router.push(const AccountRouter());
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: UserAvatar(
                        radius: 22,
                        avatarUrl: modelsWrapper.avatar.avatarUrl.isEmpty
                            ? null
                            : modelsWrapper.avatar.avatarUrl,
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
            animation: modelsWrapper.notes,
            builder: (context, _) {
              if (modelsWrapper.notes.status == ViewState.busy) {
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
                                notes: modelsWrapper.notes.notesToDisplay,
                                viewType: currentNotesViewType)),
                      ),
                    ],
                  ),
                  (modelsWrapper.notes.isFiltersApplied)
                      ? Positioned.fill(
                          bottom: 16,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FilledButton(
                                onPressed: () =>
                                    modelsWrapper.notes.clearFilters(),
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
                  _fabKey.currentState?.toggle();
                  context.router.push(const NewNoteRoute());
                },
                child: const Icon(Icons.note_add, size: 28),
              ),
              FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    _fabKey.currentState?.toggle();
                    context.router.push(const TagsManageRoute());
                  },
                  child: const Icon(Icons.collections_bookmark, size: 28)),
            ]));
  }
}
