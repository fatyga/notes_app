import 'dart:async';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

class TagsManageViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription tagsSubscription;

  List<String> _tags = [];
  List<String> get tags => _tags;

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
  String? _selectedTag;
  String? get selectedTag => _selectedTag;

  void selectTag(String tagName) {
    if (_selectedTag == tagName) {
      _selectedTag = null;
    } else {
      _selectedTag = tagName;
    }

    notifyListeners();
  }

  void updateTag(String newTagName) {
    if (_selectedTag! != newTagName) {
      final tagIndex = _tags.indexOf(_selectedTag!);
      _tags.replaceRange(tagIndex, tagIndex + 1, [newTagName]);
      _selectedTag = null;
    }
    notifyListeners();
  }

  void addTag(String newTagName) {
    if (_tags.contains(newTagName) || newTagName.isEmpty) {
      return;
    }
    _tags.add(newTagName);
    notifyListeners();
  }

  Future<void> updateTags() async {
    setViewState(ViewState.busy);

    await _notesRepo.updateTags(tags);

    setViewState(ViewState.idle,
        const UserNotification(content: 'Tags updated succesfully'));
  }
}
