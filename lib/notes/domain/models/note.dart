import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  String formattedTime;
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

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        pinned: map['pinned'],
        createdAt: map['createdAt'].toDate());
  }
  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.pinned,
      required this.createdAt})
      : formattedTime = DateFormat.yMMMd().format(createdAt);

  Note copyWith(
      {String? title, String? content, DateTime? createdAt, bool? pinned}) {
    return Note(
        id: id,
        title: title ?? this.title,
        content: content ?? this.content,
        pinned: pinned ?? this.pinned,
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
      'pinned': pinned,
      'createdAt': createdAt
    });

    return details;
  }
}

class NewNoteTemplate {
  String title;
  String content;
  DateTime createdAt;
  bool pinned;

  NewNoteTemplate({
    required this.title,
    required this.content,
  })  : createdAt = DateTime.now(),
        pinned = false;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'pinned': pinned
    };
  }
}
