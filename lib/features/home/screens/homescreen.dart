import 'package:flutter/material.dart';
import 'package:iot_relay_app/features/home/widgets/viewrelay.dart';

class Homescreen extends StatelessWidget {
const Homescreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'IoT Relay Switch',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Viewrelay()
    );
  }
}