import 'dart:async';
import 'package:notes_app/notes/domain/models/tag.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

class TagsManageViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription tagsSubscription;

  List<NoteTag> _tags = [];
  List<NoteTag> get tags => _tags;

  void startTagsSubscription() {
    tagsSubscription = _notesRepo.tagsChanges.listen((tagsList) {
      _tags = tagsList;
      notifyListeners();
    });
  }

  void stopTagsSubscription() {
    tagsSubscription.cancel();
  }

  //tags
  NoteTag? _selectedTag;
  NoteTag? get selectedTag => _selectedTag;

  void selectTag(NoteTag tag) {
    if (_selectedTag == tag) {
      _selectedTag = null;
    } else {
      _selectedTag = tag;
    }

    notifyListeners();
  }

  void updateTag(String newTagName) {
    if (_selectedTag != null) {
      if (_selectedTag!.name != newTagName) {
        _selectedTag!.name = newTagName;
        notifyListeners();
      }
    }
  }

  void addTag(String newTagName) {
    if (_tags.any((tag) => tag.name == newTagName) || newTagName.isEmpty) {
      return;
    }
    _tags.add(NoteTag(id: _notesRepo.getRandomIdForNewTag(), name: newTagName));
    notifyListeners();
  }

  Future<void> updateTags() async {
    setViewState(ViewState.busy);

    await _notesRepo.updateTags(tags);

    setViewState(ViewState.idle,
        const UserNotification(content: 'Tags updated succesfully'));
  }
}
