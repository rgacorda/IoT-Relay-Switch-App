import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/home/event/speech_event.dart';
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
              const Text(
                'IoT Relay',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 54, 62, 149),
      ),
      body: const Viewrelay(),
      floatingActionButton: MicButton(
        onPressed: _onMicPressed,
        isListening: isListening,
      ),
    );
  }
}
