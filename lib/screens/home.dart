import 'package:flutter/material.dart';
import 'package:notes_app/components/all_notes_tab.dart';
import 'package:notes_app/components/pinned_notes_tab.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/notes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        title: Text('Notes',
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 30,
                fontWeight: FontWeight.bold)),
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
        backgroundColor: Colors.grey[800],
        elevation: 12,
        onPressed: () {
          context.read<Notes>().noteManipulationMode = 'new_note';
          Navigator.pushNamed(context, '/newNote');
        },
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
