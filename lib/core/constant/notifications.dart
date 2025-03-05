import 'dart:async';
import '../../profile/domain/models/recieved_notification.dart';


int id = 0;
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();