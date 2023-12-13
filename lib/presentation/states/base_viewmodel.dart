import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';

import 'viewmodel_state.dart';

class BaseViewModel extends ChangeNotifier {
  late final _logger = appLogger(BaseViewModel);
  AppLogger get logger => _logger;
  //======================================================
  //==================== STATE SECTION ===================
  //======================================================
  ViewModelState _state = const ViewModelState.idle();
  ViewModelState get state => _state;

  /// if state is busy
  bool get isBusy =>
      _state.maybeWhen<bool>(busy: () => true, orElse: () => false);

  /// if state is idle
  bool get isIdle =>
      _state.maybeWhen<bool>(idle: () => true, orElse: () => false);

  /// if state is error
  bool get isError =>
      _state.maybeWhen<bool>(error: (value) => true, orElse: () => false);

  ///get error
  String get getError => _state.maybeWhen<String>(
      error: (value) => value.message, orElse: () => "");

  // alter state
  changeState(ViewModelState newState) {
    _state = newState;
    // notify listeners if viewmodel is still active
    if (!isDisposed) notifyListeners();
  }

  //======================================================
  //==================== SECONDARY STATE SECTION ===================
  //======================================================
  ViewModelState _secondaryState = const ViewModelState.idle();
  ViewModelState get secondaryState => _secondaryState;

  /// if state is busy
  bool get isSecondaryBusy =>
      _secondaryState.maybeWhen<bool>(busy: () => true, orElse: () => false);

  /// if state is idle
  bool get isSecondaryIdle =>
      _secondaryState.maybeWhen<bool>(idle: () => true, orElse: () => false);

  /// if state is error
  bool get isSecondaryError => _secondaryState.maybeWhen<bool>(
      error: (value) => true, orElse: () => false);

  ///get error
  String get getSecondaryError => _secondaryState.maybeWhen<String>(
      error: (value) => value.message, orElse: () => "");

  // alter state
  changeSecondaryState(ViewModelState newState) {
    _secondaryState = newState;
    // notify listeners if viewmodel is still active
    if (!isDisposed) notifyListeners();
  }

  //======================================================
  //==================== Disposed SECTION ================
  //======================================================
  bool _disposed = false;
  bool get isDisposed => _disposed;
  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }
}
