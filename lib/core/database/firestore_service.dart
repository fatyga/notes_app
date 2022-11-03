import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/core/authentication/auth.dart';
import 'package:notes_app/core/database/models.dart';

class FirestoreService {
  final FirebaseFirestore firestore;
  final String userUid;

  FirestoreService({required this.firestore, required this.userUid});

  //Notes
  Stream<List<Note>> get streamNotes {
    return firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .snapshots()
        .map(
            (list) => list.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }

  Future addNote(Map<String, dynamic> noteData) async {
    return await firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .add(noteData);
  }

  Future deleteNote(String id) async {
    return await firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(id)
        .delete();
  }

  Future updateNote(Note note, Map<String, dynamic> noteData) async {
    return await firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(note.id)
        .update(noteData);
  }

  // UserAccount
  Future updateUserAccount(Map<String, dynamic> info) {
    return firestore
        .collection('users')
        .doc(userUid)
        .set(info, SetOptions(merge: true));
  }

  Stream<UserAccount> get streamUserAccount {
    return firestore.collection('users').doc(userUid).snapshots().map((snap) =>
        UserAccount(
            avatarUrl: snap.get('avatarUrl'),
            firstName: snap.get('firstName'),
            lastName: snap.get('lastName')));
  }
}
