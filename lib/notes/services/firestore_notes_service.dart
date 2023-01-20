import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/authentication/services/firebase_auth_service.dart';
import 'package:notes_app/notes/domain/models/note.dart';

import 'package:notes_app/service_locator.dart';

import '../../authentication/services/authentication_service.dart';
import 'notes_service.dart';

class FirestoreNotesService implements NotesService {
  final FirebaseFirestore _firestore = serviceLocator<FirebaseFirestore>();
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();

  late String userUid;

  void startUserSubscription() {
    _authenticationService.authenticationChanges.listen((user) {
      if (user != null) {
        userUid = user.uid;
      }
    });
  }

  //TODO: Fix obtaining current userUid
  FirestoreNotesService() {
    userUid = FirebaseAuth.instance.currentUser!.uid;
  }

  //Notes
  @override
  Stream<List<Note>> get notesChanges {
    return _firestore
        .collection('users')
        .doc(userUid)
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
        .doc(userUid)
        .collection('notes')
        .doc(noteId)
        .snapshots()
        .map((note) {
      final noteMap = {
        'id': note.id,
        'title': note.get('title'),
        'pinned': note.get('pinned'),
        'content': note.get('content'),
        'createdAt': note.get('createdAt')
      };
      return Note.fromMap(noteMap);
    });
  }

  @override
  Future<List<Note>> savedNotes() async {
    final savedNotes = await _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .get();
    return savedNotes.docs.map((e) => Note.fromFirestore(e)).toList();
  }

  @override
  Future<Note> savedNote(String noteId) async {
    final savedNote = await _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(noteId)
        .get();
    final noteMap = {
      'id': savedNote.id,
      'title': savedNote.get('title'),
      'pinned': savedNote.get('pinned'),
      'content': savedNote.get('content'),
      'createdAt': savedNote.get('createdAt')
    };
    return Note.fromMap(noteMap);
  }

  @override
  Future addNote(Map<String, dynamic> noteData) async {
    return await _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .add(noteData);
  }

  @override
  Future deleteNote(String id) async {
    return await _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(id)
        .delete();
  }

  @override
  Future updateNote(String noteId, Map<String, dynamic> noteData) async {
    return await _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(noteId)
        .update(noteData);
  }

  // // UserAccount
  // Future updateUserAccount(Map<String, dynamic> info) {
  //   return _firestore
  //       .collection('users')
  //       .doc(userUid)
  //       .set(info, SetOptions(merge: true));
  // }
}
