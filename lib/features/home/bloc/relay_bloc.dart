import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/home/event/relay_event.dart';
import 'package:iot_relay_app/features/home/state/relay_state.dart';
import 'package:iot_relay_app/features/home/models/relay.dart';
import 'package:iot_relay_app/features/home/services/relay_services.dart';

class RelayBloc extends Bloc<RelayEvent, RelayState> {
  final RelayServices _relayServices;

  RelayBloc(this._relayServices) : super(RelayInitial()) {
    on<LoadRelays>(_onLoadRelays);
    on<ToggleRelay>(_toggleRelay);
    on<OnRelay>(_onRelay);
    on<OffRelay>(_offRelay);
  }

  Future<void> _onLoadRelays(LoadRelays event, Emitter<RelayState> emit) async {
    try {
      emit(RelayLoading());
      final relays = await _relayServices.getRelays();
      emit(RelayLoaded(relays));
    } catch (e) {
      throw Exception("Failed to fetch relays: $e");
    }
  }

  Future<void> _toggleRelay(ToggleRelay event, Emitter<RelayState> emit) async {
    try {
      await _relayServices.toggleRelay(event.id);
      final state = this.state;
      if (state is RelayLoaded) {
        final relays = state.relays.map((relay) {
          if (relay.id == event.id) {
            return Relay(
              id: relay.id,
              relay_status: !relay.relay_status,
            );
          }
          return relay;
        }).toList();
        emit(RelayLoaded(relays));
      }
    } catch (e) {
      throw Exception("Failed to toggle relay: $e");
    }
  }

  Future<void> _onRelay(OnRelay event, Emitter<RelayState> emit) async {
    try {
      await _relayServices.onRelay(event.id);
      final state = this.state;
      if (state is RelayLoaded) {
        final relays = state.relays.map((relay) {
          if (relay.id == event.id) {
            return Relay(
              id: relay.id,
              relay_status: true,
            );
          }
          return relay;
        }).toList();
        emit(RelayLoaded(relays));
      }
    } catch (e) {
      throw Exception("Failed to toggle relay: $e");
    }
  }

  Future<void> _offRelay(OffRelay event, Emitter<RelayState> emit) async {
    try {
      await _relayServices.offRelay(event.id);
      final state = this.state;
      if (state is RelayLoaded) {
        final relays = state.relays.map((relay) {
          if (relay.id == event.id) {
            return Relay(
              id: relay.id,
              relay_status: false,
            );
          }
          return relay;
        }).toList();
        emit(RelayLoaded(relays));
      }
    } catch (e) {
      throw Exception("Failed to toggle relay: $e");
    }
  }
}