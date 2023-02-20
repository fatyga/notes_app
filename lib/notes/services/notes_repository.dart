import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/service_locator.dart';
import '../domain/models/tag.dart';
import 'notes_service.dart';

class NotesRepository {
  final FirebaseFirestore _firestoreService = FirebaseFirestore.instance;
  final NotesService _notesService = serviceLocator<NotesService>();

  //notes
  Stream<List<Note>> get notesChanges => _notesService.notesChanges;
  Future<List<Note>> savedNotes() => _notesService.savedNotes();

  Stream<Note> noteChanges(String noteId) => _notesService.noteChanges(noteId);
  Future<Note> savedNote(String noteId) => _notesService.savedNote(noteId);

  Future<void> addNote(NewNoteTemplate noteTemplate) async {
    await _notesService.addNote(noteTemplate);
  }

  Future<void> updateNote(Note note) async {
    await _notesService.updateNote(note);
  }

  Future<void> deleteNote(String noteId) async {
    await _notesService.deleteNote(noteId);
  }

  //tags
  Stream<List<NoteTag>> get tagsChanges => _notesService.tagsChanges;
  Future<void> updateTags(List<NoteTag> updatedTagsList) async {
    await _notesService.updateTags(updatedTagsList);
  }

  Future<List<NoteTag>> savedTags() => _notesService.savedTags();

  Future<void> initializeTags() async {
    await _notesService.initializeTags();
  }

  String getRandomIdForNewTag() =>
      _firestoreService.collection('users').doc().id;
}
