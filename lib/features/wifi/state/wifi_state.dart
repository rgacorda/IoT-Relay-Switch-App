import 'package:iot_relay_app/features/wifi/models/wifi.dart';

abstract class WifiState {}

class WifiInitial extends WifiState {}

class WifiLoading extends WifiState {}

class WifiUpdating extends WifiState {}

class WifiLoaded extends WifiState {
  final List<Wifi> wifis;
  WifiLoaded(this.wifis);
}