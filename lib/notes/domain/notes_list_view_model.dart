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
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late StreamSubscription notesSubscription;
  late StreamSubscription tagsSubscription;

  List<NoteTag> _availableTags = [];
  List<NoteTag> get availableTags => _availableTags;

  List<Note> _notes = []; // notes fetched from firebase
  List<Note> notesToDisplay =
      []; // notes with filters applied, containing searched phrase etc.

  NotesMode mode = NotesMode.list;

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
    if (!mode.isSelection) {
      mode = NotesMode.selection;
      notesInSelection = notesInSelection;
      notifyListeners();
    }
  }

  void leaveSelectionMode() {
    mode = NotesMode.list;
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
  late StreamController<String> _searchingController;
  late StreamSubscription searchedNotesSubscription;
  late Stream<List<Note>> searchedNotes;

  void enterSearchingMode() {
    mode = NotesMode.search;
    _searchingController = StreamController<String>.broadcast();
    searchedNotes = _searchingController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .map((String phrase) {
      print(phrase);
      searchedPhrase = phrase;
      return searchNotesByPhrase(phrase);
    });
    searchedNotesSubscription = searchedNotes.listen((notes) {
      notesToDisplay = notes;
      notifyListeners();
    });
    notifyListeners();
  }

  void leaveSearchingMode() {
    searchedNotesSubscription.cancel();
    _searchingController.close();
    searchedPhrase = null;

    mode = NotesMode.list;
    notesToDisplay = _notes;
    notifyListeners();
  }

  String? searchedPhrase;
  List<Note> searchNotesByPhrase(String phrase) {
    if (phrase.isEmpty) return _notes;
    return _notes
        .where((note) =>
            note.title.contains(phrase) || note.content.contains(phrase))
        .toList();
  }

  Function(String) get searchNotes => _searchingController.add;
}
