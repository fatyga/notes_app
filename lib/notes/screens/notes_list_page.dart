import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
        title: Text('Notes', style: Theme.of(context).textTheme.headline5),
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
              onPressed: () {}, icon: const Icon(Icons.filter_alt_rounded)),
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
      body: Column(
        children: [
          AnimatedBuilder(
            animation: model,
            builder: (context, _) {
              return Tags(
                availableTags: model.availableTags,
                selectedTags: model.selectedTags,
                onTagSelect: model.selectTag,
                withEditButton: true,
                oneline: true,
              );
            },
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: AnimatedBuilder(
                  animation: model,
                  builder: (context, _) {
                    if (model.status == ViewState.busy) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return NotesList(
                        notes: model.notesToDisplay,
                        viewType: currentNotesViewType);
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 12,
        onPressed: () {
          context.router.push(const NewNoteRoute());
        },
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
