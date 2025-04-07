import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/home/bloc/relay_bloc.dart';
import 'package:iot_relay_app/features/home/bloc/speech_bloc.dart';
import 'package:iot_relay_app/features/home/event/relay_event.dart';
import 'package:iot_relay_app/features/home/screens/homescreen.dart';
import 'package:iot_relay_app/services/permissions_services.dart';
import 'package:iot_relay_app/services/relay_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PermissionHandlerService.requestPermissions();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RelayBloc(RelayServices())..add(LoadRelays()),
        ),
        BlocProvider(
          create: (_) => SpeechBloc(),
        )
      ],
      child: const MaterialApp(
        home: Homescreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
