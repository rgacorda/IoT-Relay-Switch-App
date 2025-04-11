import 'package:dio/dio.dart';
import 'package:iot_relay_app/features/home/models/relay.dart';

class RelayServices {
  static const String relayUrl = 'https://white-ferret-277781.hostingersite.com/api';

  final Dio _dio = Dio(BaseOptions(baseUrl: relayUrl, headers: {'Content-Type': 'application/json'}));

  Future<List<Relay>> getRelays() async {
  try {
    final response = await _dio.get('/getRelayStatus');
    print("Raw Response: ${response.data}");

    if (response.data is List) {
      return (response.data as List)
          .map((e) => Relay.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Unexpected response format: ${response.data.runtimeType}");
    }
  } on DioException catch (e) {
    throw Exception("Failed to fetch relays: ${e.response?.data ?? e.message}");
  }
}

  Future<void> toggleRelay(int id) async {
    try {
      await _dio.patch('/toggleRelay/$id');
    } on DioException catch (e) {
      throw Exception("Failed to toggle relay: ${e.message}");
    }
  }

  Future<void> onRelay(int id) async {
    try {
      await _dio.patch('/onRelay/$id');
    } on DioException catch (e) {
      throw Exception("Failed to toggle relay: ${e.message}");
    }
  }

  Future<void> offRelay(int id) async {
    try {
      await _dio.patch('/offRelay/$id');
    } on DioException catch (e) {
      throw Exception("Failed to toggle relay: ${e.message}");
    }
  }
}