import 'dart:async';
import 'package:notes_app/account/domain/avatar_view_model.dart';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/notes/services/notes_repository.dart';
import 'package:notes_app/notes/widgets/notes_filters.dart';
import 'package:notes_app/service_locator.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import 'models/tag.dart';

class NotesListViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();
  final AvatarViewModel avatarViewModel = serviceLocator<AvatarViewModel>();

  late StreamSubscription notesSubscription;
  late StreamSubscription tagsSubscription;

  List<NoteTag> _availableTags = [];
  List<NoteTag> get availableTags => _availableTags;

  List<Note> _notes = [];

  void startNotesSubscription() {
    avatarViewModel.startAvatarChangesSubscription();
    notesSubscription = _notesRepo.notesChanges.listen((notes) {
      _notes = notes;
      notesToDisplay = _notes;
      notifyListeners();
    });

    tagsSubscription = _notesRepo.tagsChanges.listen((tagsList) {
      _availableTags = tagsList;
      notifyListeners();
    });
  }

  void stopNotesSubscription() {
    avatarViewModel.stopAvatarChangesSubscription();
    notesSubscription.cancel();
    tagsSubscription.cancel();
  }

  // Filtering notes
  bool isFiltersApplied = false;

  void filterNotes() {
    List<Note> filteredNotes = _notes;

    filteredNotes = _filterNotesByTags(filteredNotes);

    filteredNotes = _filterNotesByTitle(filteredNotes);

    notesToDisplay = filteredNotes;
    isFiltersApplied = true;
    notifyListeners();
  }

  void clearFilters() {
    _selectedTags = [];

    titleFilterOrder = null;
    contentFilterOrder = null;

    notesToDisplay = _notes;
    isFiltersApplied = false;
    notifyListeners();
  }

  // title and content
  StringFilteringOrder? titleFilterOrder;
  StringFilteringOrder? contentFilterOrder;

  void setStringFilteringOrder(String name, StringFilteringOrder? order) {
    if (name == 'title') {
      titleFilterOrder = order;
    } else if (name == 'content') {
      contentFilterOrder = order;
    }
    notifyListeners();
  }

  List<Note> _filterNotesByTitle(List<Note> notes) {
    if (titleFilterOrder != null) {
      var notesTitles = notes.map((e) => e.title).toList();
      notesTitles.sort();

      if (titleFilterOrder == StringFilteringOrder.descending) {
        notesTitles = notesTitles.reversed.toList();
      }
      return notesTitles
          .map((title) => notes.firstWhere((note) => note.title == title))
          .toList();
    }
    return notes;
  }

  // tags
  List<String> _selectedTags = [];
  List<String> get selectedTags => _selectedTags;
  List<Note> notesToDisplay = [];

  List<Note> _filterNotesByTags(List<Note> notes) {
    if (_selectedTags.isNotEmpty) {
      return _notes
          .where(
              (note) => note.tags.any((tagId) => _selectedTags.contains(tagId)))
          .toList();
    }
    return notes;
  }

  void selectTag(String tagId) {
    if (_selectedTags.contains(tagId)) {
      _selectedTags.remove(tagId);
    } else {
      _selectedTags.add(tagId);
    }
    notifyListeners();
  }

  // Future<void> addTag(NoteTag tag) async {
  //   setViewState(ViewState.busy);
  //   if (!availableTags.contains(tag)) {
  //     availableTags.add(tag);
  //     await _notesRepo.updateTags(availableTags);
  //     setViewState(ViewState.idle);
  //   }
  //   setViewState(ViewState.idle,
  //       const UserNotification(content: 'Tag added succesfully'));
  // }
}
