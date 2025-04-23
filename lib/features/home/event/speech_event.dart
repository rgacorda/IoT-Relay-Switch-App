abstract class SpeechEvent {}

class StartListening extends SpeechEvent {}
class StopListening extends SpeechEvent {}
class UpdatePartialText extends SpeechEvent {
  final String partialText;
  UpdatePartialText(this.partialText);
}