import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/wifi/bloc/wifi_bloc.dart';
import 'package:iot_relay_app/features/wifi/event/wifi_event.dart';
import 'package:iot_relay_app/features/wifi/state/wifi_state.dart';

class WifiScreen extends StatelessWidget {
const WifiScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context){
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wifi Details',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            BlocBuilder<WifiBloc, WifiState>(
              builder: (context, state) {
                if (state is WifiLoaded) {
                  final wifi = state.wifis[0];
                  nameController.text = wifi.name;
                  passwordController.text = wifi.password;

                  return Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateColor.resolveWith((states) => const Color.fromARGB(255, 54, 62, 149)),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            final String name = nameController.text;
                            final String password = passwordController.text;

                            context.read<WifiBloc>().add(UpdateWifi(name, password));
                          },
                        ),
                      )
                    ],
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16,),
                          ElevatedButton(
                            onPressed: () {
                              context.read<WifiBloc>().add(GetWifi());
                            },
                            child: Text('Refresh'),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      )
    );
  }
}
