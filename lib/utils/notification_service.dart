import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  void setupNotificationService() async {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);

    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
    }
  }
}
