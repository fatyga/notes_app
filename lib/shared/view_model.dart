import 'package:flutter/material.dart';
import 'package:notes_app/shared/enums/view_state.dart';

class ViewModel extends ChangeNotifier {
  ViewState _status = ViewState.idle;
  ViewState get status => _status;
  void setViewState(ViewState status) {
    _status = status;
    notifyListeners();
  }
}
