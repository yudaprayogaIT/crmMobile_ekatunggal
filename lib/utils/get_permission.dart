import 'package:permission_handler/permission_handler.dart';

class GetPermission {
  static Future<bool> askLocation() async {
    final status = await Permission.location.request();

    if (status.isGranted || status.isLimited || status.isProvisional) {
      return true;
    }

    if (status.isPermanentlyDenied || status.isRestricted) {
      await openAppSettings();
    }

    return false;
  }
}
