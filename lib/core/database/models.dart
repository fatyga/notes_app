import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  bool pinned;

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc;

    return Note(
        id: doc.id,
        title: data.get('title'),
        content: data.get('content'),
        pinned: data.get('pinned'),
        createdAt: data.get('createdAt').toDate());
  }
  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.pinned,
      required this.createdAt});
}
