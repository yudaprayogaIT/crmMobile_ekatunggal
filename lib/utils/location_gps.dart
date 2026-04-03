// ignore_for_file: non_constant_identifier_names

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission; // Alias untuk 'permission_handler'
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:salesappnew/models/result_location_model.dart';

class LocationGps {
  Future<Position?> CheckLocation() async {
    try {
      // Memeriksa status izin lokasi menggunakan 'permission.Permission'
      permission.PermissionStatus status =
          await permission.Permission.location.request();
      if (status.isDenied) {
        // Jika izin ditolak, keluar dari aplikasi
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return null;
      } else if (status.isPermanentlyDenied) {
        permission.openAppSettings();
      } else if (status.isGranted) {
        // Mendapatkan posisi saat ini
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        return position;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<String> chekcAdress(ResultLocation position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      String address = '${place.name}, ${place.locality}, ${place.country}';

      return address;
    } catch (e) {
      // print('Error: $e');
      rethrow;
    }
  }

  Future<double> calculateDistance(Position start, Position end) async {
    double distanceInMeters = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );

    // Konversi jarak dalam meter menjadi kilometer
    double distanceInKm = distanceInMeters / 1000;

    return distanceInKm;
  }
}
