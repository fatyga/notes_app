import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';

enum ModelStatus { idle, busy }

class NotesViewModel extends ChangeNotifier {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription notesSubscription;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Note? selectedNote;

  ModelStatus _status = ModelStatus.idle;
  ModelStatus get status => _status;
  void setModelStatus(ModelStatus status) {
    _status = status;
    notifyListeners();
  }

  void startNotesSubscription() {
    notesSubscription = _notesRepo.existingNotes.listen((notes) {
      _notes = notes;
      notifyListeners();
    });
  }

  void stopNotesSubscription() {
    notesSubscription.cancel();
  }

  void selectNote(Note note) {
    selectedNote = note;
    notifyListeners();
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

  Future<void> deleteNote() async {
    setModelStatus(ModelStatus.busy);
    if (selectedNote != null) {
      await _notesRepo.deleteNote(selectedNote!);
    }
    selectedNote = null;
    setModelStatus(ModelStatus.idle);
  }

  Future<void> updateNote(
      {String? title, String? content, required bool changePinned}) async {
    setModelStatus(ModelStatus.busy);

    if (selectedNote != null) {
      Note updatedNote = selectedNote!.copyWith(
          title: title,
          content: content,
          pinned:
              (changePinned) ? !selectedNote!.pinned : !selectedNote!.pinned);
      await _notesRepo.updateNote(
        updatedNote,
      );
    }
    selectedNote =
        _notes.firstWhere((element) => element.id == selectedNote!.id);
    setModelStatus(ModelStatus.idle);
  }

  List<Note> filterPinnedNotes() {
    return _notes.where(((note) => note.pinned)).toList();
  }
}
