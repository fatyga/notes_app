import 'dart:async';

import 'package:flutter/material.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';
import 'models/note.dart';

enum ModelStatus { idle, busy }

class NoteUpdateViewModel extends ChangeNotifier {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late Note _note;
  Note get note => _note;

  ModelStatus _status = ModelStatus.busy;
  ModelStatus get status => _status;
  void setModelStatus(ModelStatus status) {
    _status = status;
    notifyListeners();
  }

  Future<void> loadSavedNote(String noteId) {
    return _notesRepo.savedNote(noteId).then((savedNote) {
      _note = savedNote;
      if (_status == ModelStatus.busy) {
        setModelStatus(ModelStatus.idle);
      }
    });
  }

  Future<void> updateNote(
      {required String title, required String content}) async {
    final updatedNote = note.copyWith(title: title, content: content);
    await _notesRepo.updateNote(updatedNote);
  }
}
