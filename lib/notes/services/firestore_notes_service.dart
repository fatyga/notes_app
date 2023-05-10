import 'package:cloud_firestore/cloud_firestore.dart';

import '../../authentication/authentication.dart';
import '../../service_locator.dart';
import '../notes.dart';

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

  Map<String, dynamic> convertTagsToMap(List<NoteTag> tagsList) {
    final Map<String, dynamic> tagsAsMap = {};
    for (var element in tagsList) {
      tagsAsMap[element.id] = element.name;
    }
    return tagsAsMap;
  }

  List<NoteTag> convertMapToTags(Map<String, dynamic> tagsMap) {
    final List<NoteTag> tagsList = [];
    tagsMap
        .forEach((key, value) => tagsList.add(NoteTag(id: key, name: value)));
    return tagsList;
  }

  @override
  Stream<List<NoteTag>> get tagsChanges => _firestore
      .collection('users')
      .doc(_authenticationService.getCurrentUser()!.uid)
      .snapshots(includeMetadataChanges: true)
      .map((event) => convertMapToTags(event.get('tags')));

  @override
  Future<List<NoteTag>> savedTags() async {
    final doc = await _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .get();
    return convertMapToTags(doc.get('tags'));
  }

  @override
  Future updateTags(List<NoteTag> updatedTagsList) async {
    await _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .update({'tags': convertTagsToMap(updatedTagsList)});
  }

  @override
  Future initializeTags() async {
    final randomId = _firestore.collection('users').doc().id;
    await _firestore
        .collection('users')
        .doc(_authenticationService.getCurrentUser()!.uid)
        .set({
      'tags': {randomId: 'pinned'}
    });
  }
}
