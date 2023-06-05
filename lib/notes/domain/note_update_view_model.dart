import 'dart:async';

import '../../service_locator.dart';
import '../../shared/enums/view_state.dart';
import '../../shared/view_model.dart';
import '../notes.dart';

class NoteUpdateViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  late final StreamSubscription _tagsChangesSubscription;

  late Note _note;
  Note get note => _note;

  List<NoteTag> _availableTags = [];
  List<NoteTag> get availableTags => _availableTags;

  List<String> _selectedTags = [];
  List<String> get selectedTags => _selectedTags;

  void startTagsSubscription() {
    setViewState(ViewState.busy);
    _tagsChangesSubscription = _notesRepo.tagsChanges.listen((tags) {
      _availableTags = tags;
    });
  }

  void stopTagsSubscription() {
    _tagsChangesSubscription.cancel();
  }

  Future<void> loadSavedNote(String noteId) {
    return _notesRepo.savedNote(noteId).then((savedNote) {
      _note = savedNote;
      _selectedTags = _note.tags;
      if (status == ViewState.busy) {
        setViewState(ViewState.idle);
      }
    });
  }

  Future<void> updateNote(
      {required String title, required String content}) async {
    setViewState(ViewState.busy);
    final updatedNote =
        note.copyWith(title: title, content: content, tags: _selectedTags);
    await _notesRepo.updateNote(updatedNote);
    setViewState(ViewState.idle);
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
