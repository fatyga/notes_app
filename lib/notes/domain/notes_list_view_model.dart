import 'dart:async';

import 'package:notes_app/shared/enums/view_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../service_locator.dart';
import '../../shared/notes_mode.dart';
import '../../shared/view_model.dart';
import '../notes.dart';

enum SortingOption {
  titleAlphabetical(displayName: 'Title: A-Z'),
  titleAlphabeticalReversed(displayName: 'Title: Z-A'),
  dateNewest(displayName: 'Date: Newest'),
  dateOldest(displayName: 'Date: Oldest');

  const SortingOption({required this.displayName});
  final String displayName;
}

class NotesListViewModel extends ViewModel {
  NotesListViewModel({List<Note> initialNotes = const []})
      : _notes = initialNotes,
        notesToDisplay = initialNotes;
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription notesSubscription;
  late StreamSubscription tagsSubscription;

  List<NoteTag> _availableTags = [];
  List<NoteTag> get availableTags => _availableTags;

  late List<Note> _notes; // notes fetched from firebase
  late List<Note> notesToDisplay;
  // notes with filters applied, containing searched phrase etc.

  void resetNotesToDisplay() {
    notesToDisplay = [..._notes];
  }

  NotesListPageMode get currentMode => _modes[_modes.length - 1];
  final List<NotesListPageMode> _modes = [NotesListPageMode.list];

  void _onEnterNewMode(NotesListPageMode mode) {
    switch (mode) {
      case NotesListPageMode.list:
      case NotesListPageMode.selection:
        break;
      case NotesListPageMode.search:
        prepareSearching();
        break;
      case NotesListPageMode.filter:
        applyFilters();
        break;
    }
  }

  void _onCurrentModeLeave() {
    switch (currentMode) {
      case NotesListPageMode.list:
        resetNotesToDisplay();
        break;
      case NotesListPageMode.selection:
        clearSelection();
        break;
      case NotesListPageMode.search:
        clearSearching();
        break;
      case NotesListPageMode.filter:
        clearFilters();
        break;
    }
  }

  void _onCurrentModeUpdate() {
    switch (currentMode) {
      case NotesListPageMode.list:
        resetNotesToDisplay();
        break;
      case NotesListPageMode.selection:
        break;
      case NotesListPageMode.search:
        notesToDisplay = searchNotesByPhrase(searchedPhrase!);
        break;
      case NotesListPageMode.filter:
        applyFilters();
        break;
    }
  }

  void restorePreviousMode() {
    if (_modes.length > 1) {
      _onCurrentModeLeave();
      _modes.removeLast();
      _onCurrentModeUpdate();
      notifyListeners();
    }
  }

  void enterMode(NotesListPageMode mode) {
    if (currentMode != mode) {
      _modes.add(mode);
      _onEnterNewMode(mode);
    } else {
      _onCurrentModeUpdate();
    }
    notifyListeners();
  }

  void startNotesSubscription() {
    notesSubscription = _notesRepo.notesChanges.listen((notes) {
      _notes = notes;
      _onCurrentModeUpdate();
      notifyListeners();
    });

    tagsSubscription = _notesRepo.tagsChanges.listen((tagsList) {
      _availableTags = tagsList;
      _onCurrentModeUpdate();
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

  void clearSelection() {
    selectAll = false;
    notesInSelection = [];
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
    restorePreviousMode();
    setViewState(ViewState.idle);
  }

  // Filtering notes feature
  bool isFiltersApplied = false;

  void applyFilters() {
    List<Note> notesToFilter = [..._notes];

    notesToFilter = _filterNotes(notesToFilter);
    _sortNotes(notesToFilter);

    notesToDisplay = notesToFilter;
    isFiltersApplied = true;
  }

  void clearFilters() {
    _selectedTags = [];

    resetNotesToDisplay();
    isFiltersApplied = false;
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
  late StreamController<String> _searchingController;
  late StreamSubscription searchedNotesSubscription;
  late Stream<List<Note>> searchedNotes;

  void prepareSearching() {
    notesToDisplay = [];
    searchedPhrase = '';
    _searchingController = StreamController<String>.broadcast();
    searchedNotes = _searchingController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .map((String phrase) {
      searchedPhrase = phrase;
      return searchNotesByPhrase(phrase);
    });
    searchedNotesSubscription = searchedNotes.listen((notes) {
      notesToDisplay = notes;
      notifyListeners();
    });
  }

  void clearSearching() {
    searchedNotesSubscription.cancel();
    _searchingController.close();
    searchedPhrase = null;

    resetNotesToDisplay();
  }

  String? searchedPhrase;
  List<Note> searchNotesByPhrase(String phrase) {
    if (phrase.isEmpty) return [];
    return _notes
        .where((note) =>
            note.title.contains(phrase) || note.content.contains(phrase))
        .toList();
  }

  Function(String) get searchNotes => _searchingController.add;
}
