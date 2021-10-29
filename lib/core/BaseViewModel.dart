import 'package:flutter/material.dart';

enum ViewState{
  IDLE,
  BUSY
}

class BaseViewModel extends ChangeNotifier{
  ViewState _state = ViewState.IDLE;
  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}