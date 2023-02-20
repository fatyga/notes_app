import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/notes/domain/models/tag.dart';

Map<String, dynamic> convertTagsToMap(List<NoteTag> tagsList) {
  final Map<String, dynamic> tagsAsMap = {};
  for (var element in tagsList) {
    tagsAsMap[element.id] = element.name;
  }
  return tagsAsMap;
}

List<NoteTag> convertMapToTags(Map<String, dynamic> tagsMap) {
  final List<NoteTag> tagsList = [];
  tagsMap.forEach((key, value) => tagsList.add(NoteTag(id: key, name: value)));
  return tagsList;
}

class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  String formattedTime;
  List<NoteTag> tags;

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc;

    return Note(
        id: doc.id,
        title: data.get('title'),
        content: data.get('content'),
        tags: convertMapToTags(data.get('tags')),
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
      List<NoteTag>? tags}) {
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
      'tags': convertTagsToMap(tags)
    });

    return details;
  }
}

class NewNoteTemplate {
  String title;
  String content;
  DateTime createdAt;
  List<NoteTag> tags = [];

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
      'tags': convertTagsToMap(tags)
    };
  }
}
