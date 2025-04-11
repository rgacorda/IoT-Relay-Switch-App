import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/home/bloc/relay_bloc.dart';
import 'package:iot_relay_app/features/home/event/relay_event.dart';
import 'package:iot_relay_app/features/home/event/speech_event.dart';
import 'package:iot_relay_app/features/home/state/speech_state.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  final RelayBloc relayBloc;
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _finalText = '';

  SpeechBloc({required this.relayBloc}) : super(SpeechInitial()) {
    on<StartListening>(_onStartListening);
    on<StopListening>(_onStopListening);
  }

  Future<void> _onStartListening(StartListening event, Emitter<SpeechState> emit) async {
    _finalText = '';
    emit(SpeechInitial());

    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (error) => print('Speech error: $error'),
    );

    if (available) {
      emit(SpeechListening());
      _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            _finalText = result.recognizedWords;
            print("🟢 Final: $_finalText");
          } else {
            print("🟡 Partial: ${result.recognizedWords}");
          }
        },
        listenFor: Duration(seconds: 10),
        pauseFor: Duration(seconds: 3),
      );
    }
  }

  String _convertNumberWordsToDigits(String input) {
    final numberWords = {
      'zero': '0',
      'one': '1',
      'two': '2',
      'three': '3',
      'four': '4',
      'five': '5',
      'six': '6',
      'seven': '7',
      'eight': '8',
      'nine': '9',
      'ten': '10',
    };

    numberWords.forEach((word, digit) {
      input = input.replaceAll(RegExp(r'\b' + word + r'\b'), digit);
    });

    return input;
  }

  Future<void> _onStopListening(StopListening event, Emitter<SpeechState> emit) async {
    await _speech.stop();
    _finalText = _convertNumberWordsToDigits(_finalText);
    // print('🎤 Final recognized text: $_finalText');

    _handleVoiceCommand(_finalText.toLowerCase());

    emit(SpeechStopped(finalText: _finalText));

  }

  void _handleVoiceCommand(String command){
    print('🎤 Final recognized text: $command');
    final regex = RegExp(r'number (\d+) turn (on|off)');
    final match = regex.firstMatch(command);

    if (match != null) {
      final number = int.parse(match.group(1)!);
      final action = match.group(2)!;

      
      if(action == 'on'){
        relayBloc.add(OnRelay(id: number));
      }
      else if(action == 'off'){
        relayBloc.add(OffRelay(id: number));
      }

    }
  }
}