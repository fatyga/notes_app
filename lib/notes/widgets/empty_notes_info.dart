import 'package:flutter/material.dart';
import 'package:notes_app/shared/notes_mode.dart';

class EmptyNotesInfo extends StatelessWidget {
  const EmptyNotesInfo({super.key, required this.mode});

  final NotesListPageMode mode;
  IconData getIcon() {
    switch (mode) {
      case NotesListPageMode.list:
        return Icons.note;

      case NotesListPageMode
          .selection: // TODO: This case can't be satisfied. Fix it.
        return Icons.select_all;

      case NotesListPageMode.search:
        return Icons.search_off;
      case NotesListPageMode.filter:
        return Icons.filter_alt_off_outlined;
    }
  }

  String getDescription() {
    switch (mode) {
      case NotesListPageMode.list:
        return "There aren't any notes yet.";

      case NotesListPageMode
          .selection: // TODO: This case can't be satisfied. Fix it.
        return '';

      case NotesListPageMode.search:
        return "No results for searched phrase";
      case NotesListPageMode.filter:
        return "No results for given filters.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(getIcon(), color: Colors.grey[500], size: 60),
          const SizedBox(height: 10),
          Text(getDescription(),
              style: TextStyle(color: Colors.grey[500], fontSize: 15))
        ],
      ),
    );
  }
}
