import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_relay_app/features/home/bloc/relay_bloc.dart';
import 'package:iot_relay_app/features/home/bloc/speech_bloc.dart';
import 'package:iot_relay_app/features/home/event/relay_event.dart';
import 'package:iot_relay_app/features/home/views/homescreen.dart';
import 'package:iot_relay_app/features/wifi/bloc/wifi_bloc.dart';
import 'package:iot_relay_app/features/wifi/event/wifi_event.dart';
import 'package:iot_relay_app/features/wifi/services/wifi_services.dart';
import 'package:iot_relay_app/features/wifi/views/wifi_screen.dart';
import 'package:iot_relay_app/services/permissions_services.dart';
import 'package:iot_relay_app/features/home/services/relay_services.dart';

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
          create: (_) => SpeechBloc(relayBloc: RelayBloc(RelayServices())),
        ),
        BlocProvider(create: (context) => WifiBloc(WifiServices())..add(GetWifi())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    ),
  );
}

final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => const Homescreen(),
      ),
      GoRoute(
        path: '/wifi',
        builder: (context, state) => const WifiScreen(),
      )
    ],
  );

