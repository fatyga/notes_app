import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';
import 'models/note.dart';
import 'models/tag.dart';

class NotesPreviewViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late Note _note;
  Note get note => _note;

  List<NoteTag> _availableTags = [];
  List<NoteTag> get availableTags => _availableTags;

  late StreamSubscription tagsChangeSubscription;
  late StreamSubscription noteChangeSubscription;

  void startNoteChangeSubscription(String noteId) {
    setViewState(ViewState.busy);
    tagsChangeSubscription = _notesRepo.tagsChanges.listen((tags) {
      _availableTags = tags;
    });
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

  List<String> getTagsNames() => _availableTags
      .where((tag) => _note.tags.contains(tag.id))
      .map((e) => e.name)
      .toList();
  bool isNoteContainTag(String tagName) {
    return getTagsNames().contains(tagName);
  }

  Future<void> pinUnpinNote() async {
    setViewState(ViewState.busy);
    final pinnedTag = _availableTags.firstWhere((tag) => tag.name == 'pinned');
    if (_note.tags.contains(pinnedTag.id)) {
      _note.tags.remove(pinnedTag.id);
    } else {
      _note.tags.insert(0, pinnedTag.id);
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
