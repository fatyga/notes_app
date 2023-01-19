import '../domain/models/note.dart';

abstract class NotesService {
  Stream<List<Note>> get notesChanges;
  Stream<Note> noteChanges(String noteId);
  Future<List<Note>> savedNotes();
  Future addNote(Map<String, dynamic> note);
  Future updateNote(String noteId, Map<String, dynamic> note);
  Future deleteNote(String noteId);
}
