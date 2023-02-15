import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';
import 'models/note.dart';

class NoteUpdateViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late final StreamSubscription _tagsChangesSubscription;

  late Note _note;
  Note get note => _note;

  List<String> _tags = [];
  List<String> get tags => _tags;

  List<String> _selectedTags = [];
  List<String> get selectedTags => _selectedTags;

  void startTagsSubscription() {
    setViewState(ViewState.busy);
    _tagsChangesSubscription = _notesRepo.tagsChanges.listen((tags) {
      _tags = tags;
    });
  }

  void stopTagsSubscription() {
    _tagsChangesSubscription.cancel();
  }

  Future<void> loadSavedNote(String noteId) {
    return _notesRepo.savedNote(noteId).then((savedNote) {
      _note = savedNote;
      _selectedTags = _note.tags;
      if (status == ViewState.busy) {
        setViewState(ViewState.idle);
      }
    });
  }

  Future<void> updateNote(
      {required String title, required String content}) async {
    setViewState(ViewState.busy);
    final updatedNote =
        note.copyWith(title: title, content: content, tags: _selectedTags);
    await _notesRepo.updateNote(updatedNote);
    setNotification(
        userNotification.copyWith(content: 'Note updated successfully'));
  }

  //tags
  void selectTag(String tagName) {
    if (_selectedTags.contains(tagName)) {
      _selectedTags.remove(tagName);
    } else {
      _selectedTags.add(tagName);
    }
    notifyListeners();
  }
}
