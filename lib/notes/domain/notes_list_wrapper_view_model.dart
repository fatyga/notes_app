import '../../account/account.dart';
import '../../service_locator.dart';
import '../../shared/view_model.dart';
import '../notes.dart';

class NotesListWrapperViewModel extends ViewModel {
  NotesListWrapperViewModel({this.initialNotes = const []}) {
    notesListViewModel =
        serviceLocator.get<NotesListViewModel>(param1: initialNotes);
  }

  List<Note> initialNotes;
  final AvatarViewModel avatarViewModel = serviceLocator<AvatarViewModel>();
  late final NotesListViewModel notesListViewModel;

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
