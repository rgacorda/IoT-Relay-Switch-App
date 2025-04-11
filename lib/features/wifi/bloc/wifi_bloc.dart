import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_relay_app/features/wifi/event/wifi_event.dart';
import 'package:iot_relay_app/features/wifi/services/wifi_services.dart';
import 'package:iot_relay_app/features/wifi/state/wifi_state.dart';

class WifiBloc extends Bloc<WifiEvent, WifiState> {
  final WifiServices _wifiServices = WifiServices();

  WifiBloc(wifiServices) : super(WifiInitial()) {
    on<GetWifi>(_onLoadWifi);
    on<UpdateWifi>((event, emit) => updateWifi(event.name, event.password));
  }


  Future<void> _onLoadWifi(WifiEvent event, Emitter<WifiState> emit) async {
    try {
      emit(WifiLoading());
      final wifi = await _wifiServices.getWifi();
      emit(WifiLoaded(wifi));
    } catch (e) {
      throw Exception("Failed to fetch wifi: $e");
    }
  }

  Future<void> updateWifi(String name, String password) async {
    try {
      emit(WifiUpdating());
      await _wifiServices.updateWifi(name, password);
      final wifi = await _wifiServices.getWifi();
      emit(WifiLoaded(wifi));
    } catch (e) {
      throw Exception("Failed to update wifi: $e");
    }
  }
}