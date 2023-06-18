import 'dart:async';

import 'package:notes_app/shared/enums/view_state.dart';

import '../../service_locator.dart';
import '../../shared/view_model.dart';
import '../notes.dart';

enum NotesListMode { list, selection, search }

enum SortingOption {
  titleAlphabetical(displayName: 'Title: A-Z'),
  titleAlphabeticalReversed(displayName: 'Title: Z-A'),
  dateNewest(displayName: 'Date: Newest'),
  dateOldest(displayName: 'Date: Oldest');

  const SortingOption({required this.displayName});
  final String displayName;
}

class NotesListViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription notesSubscription;
  late StreamSubscription tagsSubscription;

  List<NoteTag> _availableTags = [];
  List<NoteTag> get availableTags => _availableTags;

  List<Note> _notes = []; // notes fetched from firebase
  List<Note> notesToDisplay =
      []; // notes with filters applied, containing searched phrase etc.

  NotesListMode mode = NotesListMode.list;

  bool get isListMode => mode == NotesListMode.list;
  bool get isSelectionMode => mode == NotesListMode.selection;
  bool get isSearchMode => mode == NotesListMode.search;

  void startNotesSubscription() {
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
    notesSubscription.cancel();
    tagsSubscription.cancel();
  }

  // Selecting notes
  bool get isAnyNoteSelected =>
      notesInSelection.isNotEmpty; // used to obtain delete button state
  bool selectAll = false;
  List<Note> notesInSelection = [];

  void enterSelectionMode() {
    if (!isSelectionMode) {
      mode = NotesListMode.selection;
      notesInSelection = notesInSelection;
      notifyListeners();
    }
  }

  void leaveSelectionMode() {
    mode = NotesListMode.list;
    notesInSelection = [];
    notifyListeners();
  }

  void batchSelecting() {
    if (selectAll) {
      notesInSelection = [];
      selectAll = false;
    } else {
      notesInSelection = [...notesToDisplay];
      selectAll = true;
    }

    notifyListeners();
  }

  void switchNoteSelection(Note note) {
    if (!notesInSelection.contains(note)) {
      notesInSelection.add(note);
    } else {
      notesInSelection.remove(note);
    }
    notifyListeners();
  }

  Future<void> deleteNotesInSelection() async {
    setViewState(ViewState.busy);
    if (notesInSelection.isNotEmpty) {
      final ids = notesInSelection.map((note) => note.id).toList();
      await _notesRepo.deleteNotes(ids);
    }
    leaveSelectionMode();
    setViewState(ViewState.idle);
  }

  // Filtering notes feature
  bool isFiltersApplied = false;

  void applyFilters() {
    List<Note> notesToFilter = [..._notes];

    _sortNotes(notesToFilter);
    notesToFilter = _filterNotes(notesToFilter);

    notesToDisplay = notesToFilter;
    isFiltersApplied = true;
    notifyListeners();
  }

  void clearFilters() {
    _selectedTags = [];

    notesToDisplay = _notes;
    isFiltersApplied = false;
    notifyListeners();
  }

  // Sorting notes
  SortingOption chosenSortingOption = SortingOption.titleAlphabetical;

  void changeSortingOption(SortingOption? newOption) {
    if (newOption != null) {
      chosenSortingOption = newOption;
      notifyListeners();
    }
  }

  void _sortNotes(List<Note> notes) {
    switch (chosenSortingOption) {
      case SortingOption.titleAlphabetical:
        notes.sort((prev, next) =>
            prev.title.toLowerCase().compareTo(next.title.toLowerCase()));
        break;
      case SortingOption.titleAlphabeticalReversed:
        notes.sort((prev, next) =>
            -prev.title.toLowerCase().compareTo(next.title.toLowerCase()));
        break;
      case SortingOption.dateNewest:
        notes.sort((prev, next) => -prev.createdAt.compareTo(next.createdAt));
        break;
      case SortingOption.dateOldest:
        notes.sort((prev, next) => prev.createdAt.compareTo(next.createdAt));
        break;
    }
  }

  List<Note> _filterNotes(List<Note> notes) {
    return notes.where((note) {
      final List<bool> appliedFilters = [];

      // tags
      if (selectedTags.isNotEmpty) {
        appliedFilters.add(note.tags.any((tag) => selectedTags.contains(tag)));
      }
      return appliedFilters.isEmpty
          ? true
          : appliedFilters.every((element) => element == true);
    }).toList();
  }

  // tags
  List<String> _selectedTags = [];
  List<String> get selectedTags => _selectedTags;

  void selectTag(String tagId) {
    if (_selectedTags.contains(tagId)) {
      _selectedTags.remove(tagId);
    } else {
      _selectedTags.add(tagId);
    }
    notifyListeners();
  }

  // Searching note feature
  void enterSearchingMode() {
    mode = NotesListMode.search;
    notifyListeners();
  }

  void leaveSearchingMode() {
    mode = NotesListMode.list;
    notifyListeners();
  }

  final StreamController<String> _searchingController =
      StreamController<String>.broadcast();

  Function(String) get searchNotes => _searchingController.add;
}
