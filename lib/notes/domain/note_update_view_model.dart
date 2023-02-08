import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';
import 'models/note.dart';

class NoteUpdateViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late Note _note;
  Note get note => _note;

  Future<void> loadSavedNote(String noteId) {
    return _notesRepo.savedNote(noteId).then((savedNote) {
      _note = savedNote;
      if (status == ViewState.busy) {
        setViewState(ViewState.idle);
      }
    });
  }

  Future<void> updateNote(
      {required String title, required String content}) async {
    final updatedNote = note.copyWith(title: title, content: content);
    await _notesRepo.updateNote(updatedNote);
    setNotification(
        const UserNotification(content: 'Note updated successfully'));
  }
}
