import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/home/bloc/relay_bloc.dart';
import 'package:iot_relay_app/features/home/event/relay_event.dart';
import 'package:iot_relay_app/features/home/state/relay_state.dart';

class Viewrelay extends StatefulWidget {
  const Viewrelay({Key? key}) : super(key: key);

  @override
  _ViewrelayState createState() => _ViewrelayState();
}

class _ViewrelayState extends State<Viewrelay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelayBloc, RelayState>(
      builder: (context, state) {
        if (state is RelayLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RelayLoaded) {
          return ListView.builder(
            itemCount: state.relays.length,
            itemBuilder: (context, index) {
              final relay = state.relays[index];
              return ListTile(
                title: Text('Relay ${relay.id}'),
                subtitle: Text(relay.relay_status ? 'ON' : 'OFF'),
                trailing: Switch(
                  value: relay.relay_status,
                  onChanged: (value) {
                    context.read<RelayBloc>().add(ToggleRelay(id: relay.id));
                  },
                  activeColor: Color.fromARGB(255, 54, 62, 149),
                ),
              );
            },
          );
        } else if (state is RelayInitial) {
          return const Center(child: Text("Initializing..."));
        } else {
          return const Center(child: Text("No relays available."));
        }
      },
    );
  }
}
