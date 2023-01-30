import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/account/domain/avatar_view_model.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/view_model.dart';

class NotesListViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();
  final AvatarViewModel avatarViewModel = serviceLocator<AvatarViewModel>();

  late StreamSubscription notesSubscription;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  void startNotesSubscription() {
    avatarViewModel.startAvatarChangesSubscription();
    notesSubscription = _notesRepo.notesChanges.listen((notes) {
      _notes = notes;
      notifyListeners();
    });
  }

  void stopNotesSubscription() {
    avatarViewModel.stopAvatarChangesSubscription();
    notesSubscription.cancel();
  }

  List<Note> filterPinnedNotes() {
    return _notes.where(((note) => note.pinned)).toList();
  }
}
