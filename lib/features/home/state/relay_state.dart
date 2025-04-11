import 'package:iot_relay_app/features/home/models/relay.dart';


abstract class RelayState {}

class RelayInitial extends RelayState {}

class RelayLoading extends RelayState {}

class RelayLoaded extends RelayState {
  final List<Relay> relays;
  RelayLoaded(this.relays);
}