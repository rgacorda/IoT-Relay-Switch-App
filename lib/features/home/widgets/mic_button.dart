import 'package:flutter/material.dart';

class MicButton extends StatelessWidget {
final VoidCallback onPressed;
  final bool isListening;

  const MicButton({
    Key? key,
    required this.onPressed,
    this.isListening = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(
        isListening ? Icons.mic : Icons.mic_none,
        color: Colors.white,
      ),
      backgroundColor: isListening ? Colors.redAccent : const Color.fromARGB(255, 54, 62, 149),
    );
  }
}