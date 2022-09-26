import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Notes extends ChangeNotifier {
  final List<Note> _items = [];
  int currentNote = 0;
  String noteManipulationMode = '';

  List<Note> get notes => _items;
  int get notesCount => _items.length;

  void add(Note newNote) {
    _items.add(newNote);
    notifyListeners();
  }

  void edit(String editedTitle, String editedContent) {
    _items[currentNote].title = editedTitle;
    _items[currentNote].content = editedContent;
    notifyListeners();
  }
}

class Note {
  late DateTime time;
  late String title;
  late String content;
  late String formattedTime;
  late Color? backgroundColor;

  Note({required this.time, required this.title, required this.content}) {
    formattedTime = DateFormat.yMMMd().format(time);
    backgroundColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)][300];
  }
}
