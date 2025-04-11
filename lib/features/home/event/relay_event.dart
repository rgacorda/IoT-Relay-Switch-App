abstract class RelayEvent {}

class LoadRelays extends RelayEvent {}

class ToggleRelay extends RelayEvent {
  final int id;
  ToggleRelay({required this.id});
}

class OnRelay extends RelayEvent {
  final int id;
  OnRelay({required this.id});
}

class OffRelay extends RelayEvent {
  final int id;
  OffRelay({required this.id});
}