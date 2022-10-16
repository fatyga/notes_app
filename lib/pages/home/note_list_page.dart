import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/all_notes_tab.dart';
import 'package:notes_app/components/pinned_notes_tab.dart';
import 'package:notes_app/core/route/app_router.gr.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                AutoRouter.of(context).root.replace(AuthenticateTopRoute());
              },
              child: Text('Logout'))
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
              padding: EdgeInsets.all(16),
              child: TabBarView(
                children: [PinnedNotesTab(), AllNotesTab()],
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 12,
        onPressed: () {
          context.router.push(NoteManipulationRoute(selectedNoteIndex: null));
        },
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
