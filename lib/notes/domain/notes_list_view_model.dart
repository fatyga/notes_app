import 'dart:async';
import 'package:notes_app/account/domain/avatar_view_model.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/view_model.dart';

class NotesListViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();
  final AvatarViewModel avatarViewModel = serviceLocator<AvatarViewModel>();

  late StreamSubscription notesSubscription;
  late StreamSubscription tagsSubscription;

  List<String> _tags = [];
  List<String> get tags => _tags;

  List<Note> _notes = [];

  void startNotesSubscription() {
    avatarViewModel.startAvatarChangesSubscription();
    notesSubscription = _notesRepo.notesChanges.listen((notes) {
      _notes = notes;
      notesToDisplay = _notes;
      notifyListeners();
    });

    tagsSubscription = _notesRepo.tagsChanges.listen((tagsList) {
      _tags = tagsList;
      notifyListeners();
    });
  }

  void stopNotesSubscription() {
    avatarViewModel.stopAvatarChangesSubscription();
    notesSubscription.cancel();
    tagsSubscription.cancel();
  }

  List<Note> _filterNotesByTags() {
    if (_selectedTags.isEmpty) {
      return _notes;
    }
    return _notes
        .where((note) =>
            note.tags.any((noteTag) => _selectedTags.contains(noteTag)))
        .toList();
  }

  //tags
  List<String> _selectedTags = [];
  List<Note> notesToDisplay = [];

  void selectTag(String tagName) {
    if (_selectedTags.contains(tagName)) {
      _selectedTags.remove(tagName);
    } else {
      _selectedTags.add(tagName);
    }
    notesToDisplay = _filterNotesByTags();
    notifyListeners();
  }

  bool isTagSelected(String tagName) {
    return _selectedTags.contains(tagName);
  }
}
