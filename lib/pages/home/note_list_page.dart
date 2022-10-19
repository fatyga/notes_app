import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/all_notes_tab.dart';
import 'package:notes_app/components/pinned_notes_tab.dart';
import 'package:notes_app/core/authentication/auth.dart';
import 'package:notes_app/core/database/db.dart';
import 'package:notes_app/core/database/models.dart';
import 'package:notes_app/core/route/app_router.gr.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatelessWidget {
  NoteListPage({super.key});

  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          actions: [
            TextButton(
                onPressed: () async {
                  try {
                    var result = await AuthService.signOut();
                    context.router.replace(AuthenticateTopRoute());
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Logout'))
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [Tab(child: Text('Pinned')), Tab(child: Text('All'))],
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(16),
                child: TabBarView(
                  children: [
                    PinnedNotesTab(),
                    StreamProvider<List<Note>>.value(
                        initialData: [],
                        value: db.streamNotes(user),
                        child: AllNotesTab()),
                  ],
                ),
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 12,
          onPressed: () {
            context.router.push(NoteManipulationRoute(selectedNote: null));
          },
          child: const Icon(Icons.add, size: 40),
        ),
      );
    } else {
      return const Scaffold(body: CircularProgressIndicator());
    }
  }
}
