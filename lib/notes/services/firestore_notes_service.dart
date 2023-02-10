import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/service_locator.dart';
import '../../authentication/services/authentication_service.dart';
import 'notes_service.dart';

class FirestoreNotesService implements NotesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();

// notes
  @override
  Stream<List<Note>> get notesChanges {
    return _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .collection('notes')
        .snapshots()
        .map((queryDocumentSnapshots) => queryDocumentSnapshots.docs
            .map<Note>((queryDocumentSnapshot) =>
                Note.fromFirestore(queryDocumentSnapshot))
            .toList());
  }

  @override
  Stream<Note> noteChanges(String noteId) {
    return _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .collection('notes')
        .doc(noteId)
        .snapshots()
        .where((note) => note.exists)
        .map((note) => Note.fromFirestore(note));
  }

  @override
  Future<List<Note>> savedNotes() async {
    final savedNotes = await _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .collection('notes')
        .get();
    return savedNotes.docs.map((note) => Note.fromFirestore(note)).toList();
  }

  @override
  Future<Note> savedNote(String noteId) async {
    final savedNote = await _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .collection('notes')
        .doc(noteId)
        .get();

    return Note.fromFirestore(savedNote);
  }

  @override
  Future addNote(NewNoteTemplate noteTemplate) async {
    return await _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .collection('notes')
        .add(noteTemplate.toMap());
  }

  @override
  Future deleteNote(String id) async {
    return await _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .collection('notes')
        .doc(id)
        .delete();
  }

  @override
  Future updateNote(Note note) async {
    return await _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .collection('notes')
        .doc(note.id)
        .update(note.noteDetailsAsMap());
  }

  // tags
  @override
  Stream<List<String>> get tagsChanges => _firestore
      .collection('config')
      .doc('notes_tags')
      .snapshots()
      .map((event) => List.from(event.get('tags') as List));

  @override
  Future updateTags(List<String> updatedTagsList) async {
    await _firestore.doc('config/notes_tags').update({'tags': updatedTagsList});
  }
}
