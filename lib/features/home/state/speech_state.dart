abstract class SpeechState {}

class SpeechInitial extends SpeechState {}

class SpeechListening extends SpeechState {
  final String text;
  SpeechListening({required this.text});
}

class SpeechStopped extends SpeechState {
  final String finalText;

  SpeechStopped({required this.finalText});
}