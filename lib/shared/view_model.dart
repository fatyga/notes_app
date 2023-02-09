import 'package:flutter/material.dart';
import 'package:notes_app/shared/enums/view_state.dart';

class ViewModel extends ChangeNotifier {
  ViewState _status = ViewState.idle;
  ViewState get status => _status;

  UserNotification _userNotification = const UserNotification();
  UserNotification get userNotification => _userNotification;

  bool get isNotificationShouldMeShown => _userNotification.content.isNotEmpty;

  void setViewState(ViewState status,
      [UserNotification notification = const UserNotification()]) {
    _status = status;

    _userNotification = notification;

    notifyListeners();
  }

  void setNotification(UserNotification newNotification) {
    _userNotification = newNotification;
    notifyListeners();
  }

  void setError(String message) {
    setNotification(UserNotification(content: message, isError: true));
  }
}

class UserNotification {
  final String content;
  final bool isError;

  UserNotification copyWith({String? content, bool? isError}) {
    return UserNotification(
        content: content ?? this.content, isError: isError ?? this.isError);
  }

  const UserNotification({this.content = '', this.isError = false});
}
