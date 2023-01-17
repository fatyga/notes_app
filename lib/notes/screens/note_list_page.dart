import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/notes_view_model.dart';
import 'package:notes_app/notes/widgets/all_notes_tab.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/avatar.dart';
import 'package:notes_app/notes/widgets/pinned_notes_tab.dart';
import 'package:notes_app/route/app_router.gr.dart';
import 'package:provider/provider.dart';

import '../../authentication/services/authentication_service.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final model = serviceLocator<NotesViewModel>();
  final AuthenticationService authenticationModel =
      serviceLocator<AuthenticationService>();

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
        actions: [
          TextButton(
              onPressed: () async {
                await authenticationModel.signOut();
                context.router.pop();
              },
              child: const Text('Logout'))
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: const [
            TabBar(
              tabs: [Tab(child: Text('Pinned')), Tab(child: Text('All'))],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: TabBarView(
                children: [
                  PinnedNotesTab(),
                  AllNotesTab(),
                ],
              ),
            )),
          ],
        ),
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