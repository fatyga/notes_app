import 'package:notes_app/notes/domain/notes_list_view_model.dart';
import 'package:notes_app/shared/view_model.dart';

import '../../account/domain/avatar_view_model.dart';
import '../../service_locator.dart';

class NotesListWrapperViewModel extends ViewModel {
  final AvatarViewModel avatarViewModel = serviceLocator<AvatarViewModel>();
  final NotesListViewModel notesListViewModel =
      serviceLocator<NotesListViewModel>();

  AvatarViewModel get avatar => avatarViewModel;
  NotesListViewModel get notes => notesListViewModel;

  void startSubscriptions() {
    avatar.startAvatarChangesSubscription();
    notes.startNotesSubscription();
  }

  void stopSubscriptions() {
    avatar.stopAvatarChangesSubscription();
    notes.stopNotesSubscription();
  }
}
