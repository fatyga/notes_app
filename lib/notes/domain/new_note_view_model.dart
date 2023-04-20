import 'dart:async';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/domain/models/tag.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';

class NewNoteViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription tagsSubscription;

  List<NoteTag> _tags = [];
  List<NoteTag> get tags => _tags;

  List<String> _selectedTags = [];
  List<String> get selectedTags => _selectedTags;

  void startTagsSubscription() {
    tagsSubscription = _notesRepo.tagsChanges.listen((tags) {
      _tags = tags;
      notifyListeners();
    });
  }

  void stopTagsSubscription() {
    tagsSubscription.cancel();
  }

  Future<void> addNote(String title, String content) async {
    if (title.isEmpty || content.isEmpty) {
      setViewState(
          ViewState.idle,
          userNotification.copyWith(
              content: 'You need to fill both fields', isError: true));
      return;
    }
    setViewState(ViewState.busy);

    NewNoteTemplate noteTemplate =
        NewNoteTemplate(title: title, content: content, tags: selectedTags);

    await _notesRepo.addNote(noteTemplate);
    setViewState(ViewState.idle,
        userNotification.copyWith(content: 'Note created successfully'));
  }

  //tags
  void selectTag(String tagId) {
    if (_selectedTags.contains(tagId)) {
      _selectedTags.remove(tagId);
    } else {
      _selectedTags.add(tagId);
    }
    notifyListeners();
  }
}
