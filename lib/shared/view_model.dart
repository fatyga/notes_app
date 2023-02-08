import 'package:flutter/material.dart';
import 'package:notes_app/shared/enums/view_state.dart';

class ViewModel extends ChangeNotifier {
  ViewState _status = ViewState.idle;
  ViewState get status => _status;

  UserNotification _userNotification = const UserNotification();
  UserNotification get userNotification => _userNotification;

  void setViewState(ViewState status,
      [UserNotification notification = const UserNotification()]) {
    _status = status;
    if (status == ViewState.busy) {
      _userNotification = notification;
    }

    notifyListeners();
  }

  void setNotification(UserNotification newNotification) {
    _userNotification = newNotification;
    notifyListeners();
  }
}

class UserNotification {
  final String content;
  final bool isError;

  const UserNotification({this.content = '', this.isError = false});
}
