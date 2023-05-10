import 'dart:async';

import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../notes.dart';

abstract class TagChange {}

class TagRenamed extends TagChange {
  final String oldName;
  final String newName;

  TagRenamed({required this.oldName, required this.newName});
}

class TagCreated extends TagChange {
  final String tagName;
  TagCreated({
    required this.tagName,
  });
}

class TagDeleted extends TagChange {
  final String tagName;

  TagDeleted({required this.tagName});
}

class TagsManageViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription tagsSubscription;

  final List<String> _deletedTagsIds = [];
  List<NoteTag> _availableTags = [];
  List<NoteTag> get tags => _availableTags;

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

  Map<NoteTag, List<TagChange>> tagChanges = {};

  NoteTag getNoteTagFromId(String tagId) {
    return _availableTags.firstWhere((tag) => tag.id == tagId);
  }

  void updateTagChanges(String tagId, TagChange change) {
    if (!tagChanges.containsKey(getNoteTagFromId(tagId))) {
      tagChanges[getNoteTagFromId(tagId)] = [];
    }
    tagChanges[getNoteTagFromId(tagId)]!.insert(0, change);
  }

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
        updateTagChanges(_selectedTagId!,
            TagRenamed(oldName: tag.name, newName: newTagName));
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
    updateTagChanges(randomId, TagCreated(tagName: newTagName));
    notifyListeners();
  }

  void deleteTag() {
    if (_selectedTagId != null &&
        tags.map((tag) => tag.id).contains(_selectedTagId)) {
      updateTagChanges(
          _selectedTagId!,
          TagDeleted(
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
