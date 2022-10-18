import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/core/database/models.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Note>> streamNotes(User user) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('notes')
        .snapshots()
        .map(
            (list) => list.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }
}
