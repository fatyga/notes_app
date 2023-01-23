import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';

enum ModelStatus { idle, busy }

class NewNoteViewModel extends ChangeNotifier {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  ModelStatus _status = ModelStatus.idle;
  ModelStatus get status => _status;
  void setModelStatus(ModelStatus status) {
    _status = status;
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    setModelStatus(ModelStatus.busy);
    final noteAsMap = {
      'title': title,
      'content': content,
      'pinned': false,
      'createdAt': Timestamp.now()
    };
    await _notesRepo.addNote(noteAsMap);
    setModelStatus(ModelStatus.idle);
  }
}
