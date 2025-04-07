import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  /// Request microphone permission if not already granted
  static Future<void> requestPermissions() async {
    PermissionStatus currentStatus = await Permission.microphone.status;

    if (currentStatus.isGranted) {
      print("Microphone permission already granted");
    } else {
      PermissionStatus newStatus = await Permission.microphone.request();

      if (newStatus.isGranted) {
        print("Microphone permission granted");
      } else if (newStatus.isDenied) {
        print("Microphone permission denied");
      } else if (newStatus.isPermanentlyDenied) {
        print("Microphone permission permanently denied");
        openAppSettings(); // Optionally open settings
      }
    }
  }
}
