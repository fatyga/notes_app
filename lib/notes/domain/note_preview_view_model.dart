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
    setViewState(ViewState.busy);
    if (_note.tags.any((tag) => tag.name == 'pinned')) {
      final pinnedTagIndex =
          _note.tags.indexWhere((tag) => tag.name == 'pinned');
      _note.tags.removeAt(pinnedTagIndex);
    } else {
      final savedTags = await _notesRepo.savedTags();
      final pinnedTagIndex =
          savedTags.indexWhere((tag) => tag.name == 'pinned');
      _note.tags.insert(0, savedTags.elementAt(pinnedTagIndex));
    }
    await _notesRepo.updateNote(_note);
    setNotification(userNotification.copyWith(
        content:
            'Note ${note.tags.contains('pinned') ? "pinned" : "unpinned"} successfully.'));
  }

  Future<void> deleteNote(String noteId) async {
    await _notesRepo.deleteNote(noteId);
    setNotification(
        userNotification.copyWith(content: 'Note deleted successfully.'));
  }
}
