import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/home/event/speech_event.dart';
import 'package:iot_relay_app/features/home/state/speech_state.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _finalText = '';

  SpeechBloc() : super(SpeechInitial()) {
    on<StartListening>(_onStartListening);
    on<StopListening>(_onStopListening);
  }

  Future<void> _onStartListening(StartListening event, Emitter<SpeechState> emit) async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (error) => print('Speech error: $error'),
    );

    if (available) {
      emit(SpeechListening());
      _speech.listen(
        onResult: (result) {
          _finalText = result.recognizedWords;
        },
      );
    }
  }

  Future<void> _onStopListening(StopListening event, Emitter<SpeechState> emit) async {
    await _speech.stop();
    print('🎤 Final recognized text: $_finalText');
    emit(SpeechStopped(finalText: _finalText));
  }
}