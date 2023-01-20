import '../domain/models/note.dart';

abstract class NotesService {
  Stream<List<Note>> get notesChanges;
  Future<List<Note>> savedNotes();
  Stream<Note> noteChanges(String noteId);
  Future<Note> savedNote(String noteId);
  Future addNote(Map<String, dynamic> note);
  Future updateNote(String noteId, Map<String, dynamic> note);
  Future deleteNote(String noteId);
}
