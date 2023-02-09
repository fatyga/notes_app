import 'dart:async';
import 'package:notes_app/notes/domain/models/note.dart';
import 'package:notes_app/shared/enums/view_state.dart';
import 'package:notes_app/shared/view_model.dart';

import '../../service_locator.dart';
import '../services/notes_repository.dart';

class NewNoteViewModel extends ViewModel {
  final NotesRepository _notesRepo = serviceLocator<NotesRepository>();

  Future<void> addNote(String title, String content) async {
    setViewState(ViewState.busy);

    NewNoteTemplate noteTemplate =
        NewNoteTemplate(title: title, content: content);

    await _notesRepo.addNote(noteTemplate);
    setViewState(ViewState.idle,
        userNotification.copyWith(content: 'Note created successfully'));
  }
}
