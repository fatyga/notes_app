import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';
import 'models/note.dart';

class NotesPreviewViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late Note _note;
  Note get note => _note;

  late StreamSubscription noteChangeSubscription;
  void startNoteChangeSubscription(String noteId) {
    setViewState(ViewState.busy);
    noteChangeSubscription = _notesRepo.noteChanges(noteId).listen((note) {
      _note = note;
      if (status == ViewState.busy) {
        setViewState(ViewState.idle);
        return;
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
    setNotification(UserNotification(
        content: 'Note ${note.pinned ? "pinned" : "unpinned"} successfully.'));
  }

  Future<void> deleteNote(String noteId) async {
    await _notesRepo.deleteNote(noteId);
    setNotification(
        const UserNotification(content: 'Note deleted successfully.'));
  }
}
