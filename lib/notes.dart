import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Notes extends ChangeNotifier {
  final List<Note> _items = [];
  Note? selectedNote;

  String noteManipulationMode = '';
  String notesViewMode = 'all';

  List<Note> get notes => _items;
  int get notesCount => _items.length;

  void add(Note newNote) {
    _items.add(newNote);
    notifyListeners();
  }

  void edit(String editedTitle, String editedContent) {
    selectedNote?.title = editedTitle;
    selectedNote?.content = editedContent;
    notifyListeners();
  }

  void pin_unpin() {
    selectedNote!.isPinned = !selectedNote!.isPinned;
    notifyListeners();
  }

  void changeViewMode(String newMode) {
    notesViewMode = newMode;
    notifyListeners();
  }
}

class Note {
  DateTime time;
  String title;
  String content;
  late String formattedTime;
  Color? backgroundColor;

  bool isPinned = false;

  Note({required this.time, required this.title, required this.content}) {
    formattedTime = DateFormat.yMMMd().format(time);
    backgroundColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)][300];
  }
}
