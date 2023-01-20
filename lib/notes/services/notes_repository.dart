import 'package:flutter/material.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/firestore_notes_service.dart';
import 'package:notes_app/service_locator.dart';

import 'notes_service.dart';

class NotesRepository {
  final NotesService _notesService = serviceLocator<NotesService>();

  Stream<List<Note>> get notesChanges => _notesService.notesChanges;
  Future<List<Note>> savedNotes() => _notesService.savedNotes();

  Stream<Note> noteChanges(String noteId) => _notesService.noteChanges(noteId);
  Future<Note> savedNote(String noteId) => _notesService.savedNote(noteId);

  Future<void> addNote(Map<String, dynamic> newNote) async {
    await _notesService.addNote(newNote);
  }

  Future<void> updateNote(Note note) async {
    await _notesService.updateNote(note.id, note.toMap());
  }

  Future<void> deleteNote(String noteId) async {
    await _notesService.deleteNote(noteId);
  }
}
