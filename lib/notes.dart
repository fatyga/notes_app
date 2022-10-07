import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Notes extends ChangeNotifier {
  final List<Note> _items = [];
  Note? selectedNote;

  String noteManipulationMode = '';

  List<Note> get notes => _items;
  int get notesCount => _items.length;

  void add(Note newNote) {
    _items.add(newNote);
    notifyListeners();
  }

  void edit(int index, String title, String content) {
    notes[index].title = title;
    notes[index].content = content;
    // final index = notes.indexOf(oldNote);
    // notes[index] = editedNote;
    notifyListeners();
  }

  void pinUnpin(int index) {
    notes[index].isPinned = !notes[index].isPinned;
    notifyListeners();
  }
}

class Note {
  DateTime dateTime;
  String createdAt;
  String title;
  String content;
  Color? backgroundColor;

  bool isPinned;

  Note(
      {required this.dateTime,
      required this.title,
      required this.content,
      this.isPinned = false,
      Color? backgroundColor})
      : createdAt = DateFormat.yMMMd().format(dateTime),
        backgroundColor =
            Colors.primaries[Random().nextInt(Colors.primaries.length)][300];

  // Note copyWith(
  //         {DateTime? dateTime,
  //         String? title,
  //         bool? isPinned,
  //         String? content,
  //         Color? backgroundColor}) =>
  //     Note(
  //         dateTime: dateTime ?? this.dateTime,
  //         title: title ?? this.title,
  //         content: content ?? this.content,
  //         backgroundColor: backgroundColor ?? this.backgroundColor,
  //         isPinned: isPinned ?? this.isPinned);
}
