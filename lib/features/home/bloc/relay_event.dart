abstract class RelayEvent {}

class LoadRelays extends RelayEvent {}

class ToggleRelay extends RelayEvent {
  final int id;
  ToggleRelay({required this.id});
}