import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Notes extends ChangeNotifier {
  final List<Note> _items = [];

  List<Note> get notes => _items;

  int get notesCount => _items.length;

  void add(Note newNote) {
    _items.add(newNote);
    notifyListeners();
  }

  void edit(Note oldNote, Note editedNote) {
    final index = _items.indexOf(oldNote);
    _items[index] = editedNote;
    notifyListeners();
  }

  void pinUnpin(Note note) {
    final index = _items.indexOf(note);
    final selectedNote = _items[index];
    selectedNote.isPinned = !selectedNote.isPinned;
    notifyListeners();
  }
}

class Note {
  String createdAt;
  String title;
  String content;
  Color backgroundColor;
  bool isPinned = false;

  Note({
    required DateTime dateTime,
    required this.title,
    required this.content,
    Color? color,
    isPinned = false,
  })  : backgroundColor =
            Colors.primaries[Random().nextInt(Colors.primaries.length)][300]!,
        createdAt = DateFormat.yMMMd().format(dateTime);

  Note copyWith({
    String? title,
    String? content,
    bool? isPinned,
    Color? backgroundColor,
  }) =>
      Note(
        dateTime: DateTime.parse(createdAt),
        title: title ?? this.title,
        content: content ?? this.content,
        color: backgroundColor ?? this.backgroundColor,
        isPinned: isPinned ?? this.isPinned,
      );
}
