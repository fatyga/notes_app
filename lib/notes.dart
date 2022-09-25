import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Notes extends ChangeNotifier {
  final List<Note> _items = [];
  int _currentNote = 0;

  int get currentNote => _currentNote;

  set currentNote(int index) {
    _currentNote = index;
  }

  List<Note> get notes => _items;
  int get notesCount => _items.length;

  void add(Note newNote) {
    _items.add(newNote);
    notifyListeners();
  }
}

class Note {
  late DateTime time;
  late String title;
  late String content;
  late String formattedTime;
  late Color? backgroundColor;

  Note({required time, required title, required content}) {
    this.time = time;
    this.title = title;
    this.content = content;
    formattedTime = DateFormat.yMMMd().format(time);
    backgroundColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)][300];
  }
}
