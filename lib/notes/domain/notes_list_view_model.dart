import 'dart:async';
import 'package:notes_app/account/domain/avatar_view_model.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/tag.dart';

class NotesListViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();
  final AvatarViewModel avatarViewModel = serviceLocator<AvatarViewModel>();

  late StreamSubscription notesSubscription;
  late StreamSubscription tagsSubscription;

  List<NoteTag> _tags = [];
  List<NoteTag> get tags => _tags;

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
  List<NoteTag> _selectedTags = [];
  List<NoteTag> get selectedTags => _selectedTags;
  List<Note> notesToDisplay = [];

  void selectTag(NoteTag tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    notesToDisplay = _filterNotesByTags();
    notifyListeners();
  }

  Future<void> addTag(NoteTag tag) async {
    setViewState(ViewState.busy);
    if (!tags.contains(tag)) {
      tags.add(tag);
      await _notesRepo.updateTags(tags);
      setViewState(ViewState.idle);
    }
    setViewState(ViewState.idle,
        const UserNotification(content: 'Tag added succesfully'));
  }
}
