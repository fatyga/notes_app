import 'package:flutter/material.dart';

class EmptyNotesInfo extends StatelessWidget {
  const EmptyNotesInfo(
      {super.key,
      required this.isListMode,
      required this.isFilterMode,
      required this.isSearchingMode,
      required this.searchedPhrase});

  final bool isListMode;
  final bool isFilterMode;
  final bool isSearchingMode;

  final String? searchedPhrase;

  IconData getIcon() {
    if (isListMode) {
      return Icons.note;
    } else if (isFilterMode) {
      return Icons.filter_alt_off_outlined;
    } else if (isSearchingMode) {
      if (searchedPhrase != null) {
        if (searchedPhrase!.isEmpty) {
          return Icons.search;
        } else {
          return Icons.search_off;
        }
      }
      return Icons.question_mark;
    } else {
      return Icons.question_mark;
    }
  }

  String getDescription() {
    if (isListMode) {
      return "There aren't any notes yet";
    } else if (isFilterMode) {
      return "No results for given filters";
    } else if (isSearchingMode) {
      if (searchedPhrase != null) {
        if (searchedPhrase!.isEmpty) {
          return "Start typing to search...";
        } else {
          return "No results for phrase: \"$searchedPhrase\"";
        }
      }
      return "Unknown";
    } else {
      return "Unknown";
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
