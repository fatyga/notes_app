import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/core/database/models.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  //Notes
  Stream<List<Note>> streamNotes(User user) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .snapshots()
        .map(
            (list) => list.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }

  Future addNote(User user, Map<String, dynamic> noteData) async {
    return await _db
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .add(noteData);
  }

  Future updateNote(User user, Note note, Map<String, dynamic> noteData) async {
    return await _db
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .doc(note.id)
        .update(noteData);
  }

  // UserAccount
  Future updateUserAccount(User user, Map<String, dynamic> info) {
    return _db
        .collection('users')
        .doc(user.uid)
        .set(info, SetOptions(merge: true));
  }

  Stream<UserAccount> streamUserAccount(User user) {
    return _db.collection('users').doc(user.uid).snapshots().map((snap) =>
        UserAccount(
            avatarUrl: snap.get('avatarUrl'),
            firstName: snap.get('firstName'),
            lastName: snap.get('lastName')));
  }
}
