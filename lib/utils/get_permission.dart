import 'package:permission_handler/permission_handler.dart';

class GetPermission {
  static Future<bool> askLocation() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isDenied) {
      return askLocation();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return askLocation();
    } else {
      return true;
    }
  }
}
