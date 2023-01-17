import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/authentication/services/authentication_service.dart';
import 'package:notes_app/notes/domain/models/note.dart';

import 'package:notes_app/service_locator.dart';

class NotesService {
  final FirebaseFirestore _firestore = serviceLocator<FirebaseFirestore>();
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();

  late String userUid;

  void startUserSubscription() {
    _authenticationService.userNotification.listen((user) {
      if (user != null) {
        userUid = user.uid;
      }
    });
  }

  //TODO: Fix obtaining current userUid
  NotesService() {
    userUid = FirebaseAuth.instance.currentUser!.uid;
  }

  //Notes
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> get streamNotes {
    return _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs);
  }

  Future addNote(Map<String, dynamic> noteData) async {
    return await _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .add(noteData);
  }

  Future deleteNote(String id) async {
    return await _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(id)
        .delete();
  }

  Future updateNote(String noteId, Map<String, dynamic> noteData) async {
    return await _firestore
        .collection('users')
        .doc(userUid)
        .collection('notes')
        .doc(noteId)
        .update(noteData);
  }

  // UserAccount
  Future updateUserAccount(Map<String, dynamic> info) {
    return _firestore
        .collection('users')
        .doc(userUid)
        .set(info, SetOptions(merge: true));
  }
}
