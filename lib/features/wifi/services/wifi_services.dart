import 'package:dio/dio.dart';
import 'package:iot_relay_app/features/wifi/models/wifi.dart';

class WifiServices {
  static const String relayUrl = 'https://white-ferret-277781.hostingersite.com/api';

  final Dio _dio = Dio(BaseOptions(baseUrl: relayUrl, headers: {'Content-Type': 'application/json'}));

  Future<List<Wifi>> getWifi() async {
    try {
      final response = await _dio.get('/wifi');
      if (response.data is List) {
        return (response.data as List)
            .map((e) => Wifi.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Unexpected response format: ${response.data.runtimeType}");
      }
    } on DioException catch (e) {
      throw Exception("Failed to fetch relays: ${e.response?.data ?? e.message}");
    }
  }


  Future<Wifi> updateWifi(String name, String password) async {
    try {
      final response = await _dio.put('/wifi/1', data: {'name': name, 'password': password});
      return Wifi.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to update wifi: ${e.response?.data ?? e.message}");
    }
  }
}