import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/home/bloc/relay_bloc.dart';
import 'package:iot_relay_app/features/home/bloc/relay_event.dart';
import 'package:iot_relay_app/features/home/screens/homescreen.dart';
import 'package:iot_relay_app/services/relay_services.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Homescreen(),
//     )
//   );
// }

void main () {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => RelayBloc(RelayServices())..add(LoadRelays())),
    ], child: const MaterialApp(home: Homescreen(), debugShowCheckedModeBanner: false,))
  );
}