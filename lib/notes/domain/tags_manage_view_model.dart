import 'dart:async';
import 'package:notes_app/notes/domain/models/tag.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

abstract class TagChange {}

class TagRenamed implements TagChange {
  final String tagId;
  final String oldName;
  final String newName;

  TagRenamed(
      {required this.tagId, required this.oldName, required this.newName});
}

class TagCreated implements TagChange {
  final String tagId;
  final String tagName;
  TagCreated({required this.tagName, required this.tagId});
}

class TagDeleted implements TagChange {
  final String tagId;
  final String tagName;

  TagDeleted({required this.tagId, required this.tagName});
}

class TagsManageViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription tagsSubscription;

  List<String> _deletedTagsIds = [];
  List<NoteTag> _availableTags = [];
  List<NoteTag> get tags => _availableTags;

  List<TagChange> tagChanges = [];

  void startTagsSubscription() {
    tagsSubscription = _notesRepo.tagsChanges.listen((tagsList) {
      _availableTags = tagsList;
      notifyListeners();
    });
  }

  void stopTagsSubscription() {
    tagsSubscription.cancel();
  }

  //tags
  String? _selectedTagId;
  String? get selectedTag => _selectedTagId;

  String getSelectedTagName() =>
      _availableTags.firstWhere((tag) => tag.id == _selectedTagId).name;

  void selectTag(String tagId) {
    if (_selectedTagId == tagId) {
      _selectedTagId = null;
    } else {
      _selectedTagId = tagId;
    }

    notifyListeners();
  }

  void updateTag(String newTagName) {
    if (_selectedTagId != null) {
      final tag =
          _availableTags.firstWhere((element) => element.id == _selectedTagId);
      if (tag.name != newTagName) {
        tagChanges.add(TagRenamed(
            tagId: _selectedTagId!, oldName: tag.name, newName: newTagName));
        tag.name = newTagName;
      }
      _selectedTagId = null;
      notifyListeners();
    }
  }

  void addTag(String newTagName) {
    if (_availableTags.any((tag) => tag.name == newTagName) ||
        newTagName.isEmpty) {
      return;
    }
    final randomId = _notesRepo.getRandomIdForNewTag();
    _availableTags.add(NoteTag(id: randomId, name: newTagName));
    tagChanges.add(TagCreated(tagId: randomId, tagName: newTagName));
    notifyListeners();
  }

  void deleteTag() {
    if (_selectedTagId != null &&
        tags.map((tag) => tag.id).contains(_selectedTagId)) {
      tagChanges.add(TagDeleted(
          tagId: _selectedTagId!,
          tagName: _availableTags
              .firstWhere((tag) => tag.id == _selectedTagId!)
              .name));
      tags.removeWhere((tag) => tag.id == _selectedTagId);
      _deletedTagsIds.add(_selectedTagId!);
    }
    _selectedTagId = null;
    notifyListeners();
  }

  Future<void> updateTags() async {
    setViewState(ViewState.busy);
    if (_deletedTagsIds.isNotEmpty) {
      final notes = await _notesRepo.savedNotes();
      await _notesRepo.removeReferencesToDeletedTag(notes, _deletedTagsIds);
    }
    await _notesRepo.updateTags(tags);

    setViewState(ViewState.idle,
        const UserNotification(content: 'Tags updated succesfully'));
  }
}
