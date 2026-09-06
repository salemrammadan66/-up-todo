abstract class FocusState {}

class FocusInitial extends FocusState {}

class FocusRunning extends FocusState {
  final int elapsedSeconds;
  final int totalSeconds;

  FocusRunning({required this.elapsedSeconds, required this.totalSeconds});
}

class FocusPaused extends FocusState {
  final int elapsedSeconds;
  final int totalSeconds;

  FocusPaused({required this.elapsedSeconds, required this.totalSeconds});
}