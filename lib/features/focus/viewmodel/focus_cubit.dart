import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'focus_state.dart';

class FocusCubit extends Cubit<FocusState> {
  FocusCubit() : super(FocusInitial());

  static const int totalSeconds = 30 * 60;

  int elapsedSeconds = 0;
  Timer? _timer;

  void toggleFocus() {
    if (state is FocusRunning) {
      _pause();
    } else {
      _start();
    }
  }

  void _start() {
    emit(FocusRunning(elapsedSeconds: elapsedSeconds, totalSeconds: totalSeconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (elapsedSeconds < totalSeconds) {
        elapsedSeconds++;
        emit(FocusRunning(elapsedSeconds: elapsedSeconds, totalSeconds: totalSeconds));
      } else {
        _pause();
      }
    });
  }

  void _pause() {
    _timer?.cancel();
    emit(FocusPaused(elapsedSeconds: elapsedSeconds, totalSeconds: totalSeconds));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}