import 'dart:async';
import 'package:notes_app/notes/domain/models/tag.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

class TagsManageViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription tagsSubscription;

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
    _availableTags
        .add(NoteTag(id: _notesRepo.getRandomIdForNewTag(), name: newTagName));
    notifyListeners();
  }

  Future<void> updateTags() async {
    setViewState(ViewState.busy);

    await _notesRepo.updateTags(tags);

    setViewState(ViewState.idle,
        const UserNotification(content: 'Tags updated succesfully'));
  }
}
