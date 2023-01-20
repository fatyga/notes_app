import 'dart:async';

import 'package:flutter/material.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';
import 'models/note.dart';

enum ModelStatus { idle, busy }

class NotesPreviewViewModel extends ChangeNotifier {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late Note _note;
  Note get note => _note;

  ModelStatus _status = ModelStatus.busy;
  ModelStatus get status => _status;
  void setModelStatus(ModelStatus status) {
    _status = status;
    notifyListeners();
  }

  late StreamSubscription noteChangeSubscription;
  void startNoteChangeSubscription(String noteId) {
    noteChangeSubscription = _notesRepo.noteChanges(noteId).listen((note) {
      _note = note;
      if (status == ModelStatus.busy) {
        _status = ModelStatus.idle;
      }
      notifyListeners();
    });
  }

  void stopNoteChangeSubscription() {
    noteChangeSubscription.cancel();
    notifyListeners();
  }

  Future<void> pinUnpinNote() async {
    await _notesRepo.updateNote(note.copyWith(pinned: !note.pinned));
  }

  Future<void> deleteNote(String noteId) async {
    await _notesRepo.deleteNote(noteId);
  }
}