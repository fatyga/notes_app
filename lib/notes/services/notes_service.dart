import '../notes.dart';

abstract class NotesService {
  // notes
  Stream<List<Note>> get notesChanges;
  Future<List<Note>> savedNotes();
  Stream<Note> noteChanges(String noteId);
  Future<Note> savedNote(String noteId);
  Future addNote(NewNoteTemplate note);
  Future updateNote(Note note);
  Future deleteNote(String noteId);
  Future deleteNotes(List<String> ids);

  //tags
  Stream<List<NoteTag>> get tagsChanges;
  Future updateTags(List<NoteTag> updatedTagsList);
  Future<List<NoteTag>> savedTags();
  Future initializeTags();
}
