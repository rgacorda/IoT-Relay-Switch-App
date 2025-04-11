abstract class WifiEvent {}

class GetWifi extends WifiEvent {}

class UpdateWifi extends WifiEvent {
  final String name;
  final String password;

  UpdateWifi(this.name, this.password);
}