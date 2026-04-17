// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekareach/utils/local_data.dart';

class NetworkHelper {
  /// Cek apakah perangkat terhubung ke jaringan (WiFi/Mobile)
  static Future<bool> isConnectedToNetwork() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Ping ke server tertentu untuk pastikan server bisa diakses
  static Future<bool> canReachServer() async {
    try {
      String url = await LocalData().getData("url");
      final uri = Uri.parse(url);
      final httpClient = HttpClient();
      httpClient.connectionTimeout = const Duration(seconds: 5);

      final request = await httpClient.getUrl(uri);
      final response = await request.close();

      return response.statusCode >= 200 && response.statusCode < 500;
    } catch (e) {
      return false;
    }
  }

  /// Cek koneksi dan ping ke server, default ke google
  static Future<bool> hasInternetAccess(
      {String testUrl = 'https://google.com'}) async {
    final connected = await isConnectedToNetwork();
    if (!connected) return false;

    return await canReachServer();
  }
}
