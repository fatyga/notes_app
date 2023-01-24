import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';

class NewNoteViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  Future<void> addNote(String title, String content) async {
    setViewState(ViewState.busy);
    final noteAsMap = {
      'title': title,
      'content': content,
      'pinned': false,
      'createdAt': Timestamp.now()
    };
    await _notesRepo.addNote(noteAsMap);
    setViewState(ViewState.idle);
  }
}
