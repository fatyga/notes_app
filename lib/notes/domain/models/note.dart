import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  String formattedTime;
  List<String> tags;

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc;

    return Note(
        id: doc.id,
        title: data.get('title'),
        content: data.get('content'),
        tags: List<String>.from(data.get('tags')),
        createdAt: data.get('createdAt').toDate());
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        tags: map['tags'],
        createdAt: map['createdAt'].toDate());
  }
  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.tags,
      required this.createdAt})
      : formattedTime = DateFormat.yMMMd().format(createdAt);

  Note copyWith(
      {String? title,
      String? content,
      DateTime? createdAt,
      List<String>? tags}) {
    return Note(
        id: id,
        title: title ?? this.title,
        content: content ?? this.content,
        tags: tags ?? this.tags,
        createdAt: createdAt ?? this.createdAt);
  }

  Map<String, dynamic> noteDetailsAsMap({bool withId = false}) {
    Map<String, dynamic> details = {};
    if (withId) {
      details['id'] = id;
    }

    details.addAll({
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'tags': tags
    });

    return details;
  }
}

class NewNoteTemplate {
  String title;
  String content;
  DateTime createdAt;
  List<String> tags = [];

  NewNoteTemplate({
    required this.title,
    required this.content,
    required this.tags,
  }) : createdAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'tags': tags
    };
  }
}
