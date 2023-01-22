import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';

enum ModelStatus { idle, busy }

class NotesListViewModel extends ChangeNotifier {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription notesSubscription;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  ModelStatus _status = ModelStatus.idle;
  ModelStatus get status => _status;
  void setModelStatus(ModelStatus status) {
    _status = status;
    notifyListeners();
  }

  void startNotesSubscription() {
    notesSubscription = _notesRepo.notesChanges.listen((notes) {
      _notes = notes;
      notifyListeners();
    });
  }

  void stopNotesSubscription() {
    notesSubscription.cancel();
  }

  // notes manipulation
  Future<void> addNote(String title, String content) async {
    setModelStatus(ModelStatus.busy);
    await _notesRepo.addNote({
      'title': title,
      'content': content,
      'pinned': false,
      'createdAt': Timestamp.now()
    });
    setModelStatus(ModelStatus.idle);
  }

  List<Note> filterPinnedNotes() {
    return _notes.where(((note) => note.pinned)).toList();
  }
}
