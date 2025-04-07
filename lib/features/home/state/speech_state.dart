abstract class SpeechState {}

class SpeechInitial extends SpeechState {}

class SpeechListening extends SpeechState {}

class SpeechStopped extends SpeechState {
  final String finalText;

  SpeechStopped({required this.finalText});
}