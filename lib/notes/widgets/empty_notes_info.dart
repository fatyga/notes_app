import 'package:flutter/material.dart';
import 'package:notes_app/shared/notes_mode.dart';

class EmptyNotesInfo extends StatelessWidget {
  const EmptyNotesInfo({super.key, required this.mode});

  final NotesMode mode;
  IconData getIcon() {
    switch (mode) {
      case NotesMode.list:
        return Icons.note;

      case NotesMode.selection: // TODO: This case can't be satisfied. Fix it.
        return Icons.select_all;

      case NotesMode.search:
        return Icons.search_off;
      case NotesMode.filter:
        return Icons.filter_alt_off_outlined;
    }
  }

  String getDescription() {
    switch (mode) {
      case NotesMode.list:
        return "There aren't any notes yet.";

      case NotesMode.selection: // TODO: This case can't be satisfied. Fix it.
        return '';

      case NotesMode.search:
        return "No results for searched phrase";
      case NotesMode.filter:
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
