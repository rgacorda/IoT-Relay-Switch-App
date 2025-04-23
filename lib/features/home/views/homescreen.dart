import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_relay_app/features/home/event/speech_event.dart';
import 'package:iot_relay_app/features/home/state/speech_state.dart';
import 'package:iot_relay_app/features/home/widgets/mic_button.dart';
import 'package:iot_relay_app/features/home/widgets/viewrelay.dart';
import 'package:iot_relay_app/features/home/bloc/speech_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isListening = false;


  void _onMicPressed() {
    setState(() => isListening = !isListening);

    final speechBloc = context.read<SpeechBloc>();

    if (isListening) {
      speechBloc.add(StartListening());
    } else {
      speechBloc.add(StopListening());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Image.asset('assets/logo/logo2.png', width: 160, height: 160),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push('/wifi'),
                child: Text(
                  'WiFi',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 54, 62, 149),
      ),
      body: Column(
        children: [
          BlocBuilder<SpeechBloc, SpeechState>(
            builder: (context, state) {
              String speechText = '';
              if (state is SpeechListening) {
                speechText = state.text;
              } else if (state is SpeechStopped) {
                speechText = state.finalText;
              }

              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: speechText.isNotEmpty ? 1.0 : 0.0,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.grey.shade100,
                  child: Text(
                    '"$speechText"',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              );
            },
          ),
          const Expanded(child: Viewrelay()),
        ],
      ),

      floatingActionButton: MicButton(
        onPressed: _onMicPressed,
        isListening: isListening,
      ),
    );
  }
}
