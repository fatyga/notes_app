import 'package:flutter/material.dart';
import 'package:notes_app/components/all_notes_tab.dart';
import 'package:notes_app/components/pinned_notes_tab.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      //TODO: Fix the appBar which is covered by the notification bar
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        title: Text(
          'Notes',
          style: TextStyle(
              color: Colors.grey[100],
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: const [
              TabBar(
                tabs: [
                  Tab(child: Text('Pinned')),
                  Tab(child: Text('All')),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TabBarView(
                    children: [
                      PinnedNotesTab(),
                      AllNotesTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        elevation: 12,
        onPressed: () {
          Navigator.pushNamed(context, '/newNote');
        },
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
