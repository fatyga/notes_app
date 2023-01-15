import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/notes_service.dart';
import 'package:notes_app/service_locator.dart';

class NotesRepository {
  final NotesService _notes = serviceLocator<NotesService>();

  Stream<List<Note>> get existingNotes =>
      _notes.streamNotes.map((queryDocumentSnapshots) => queryDocumentSnapshots
          .map<Note>((queryDocumentSnapshot) =>
              Note.fromFirestore(queryDocumentSnapshot))
          .toList());

  Future<void> addNote(Map<String, dynamic> newNote) async {
    await _notes.addNote(newNote);
  }

  Future<void> updateNote(Note note) async {
    await _notes.updateNote(note.id, note.toMap());
  }

  Future<void> deleteNote(Note note) async {
    await _notes.deleteNote(note.id);
  }
}
