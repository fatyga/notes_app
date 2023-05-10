import '../../account/account.dart';
import '../../service_locator.dart';
import '../../shared/view_model.dart';
import '../notes.dart';

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
