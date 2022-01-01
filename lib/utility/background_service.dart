import 'dart:isolate';
import 'dart:ui';

import 'package:firstffasubmission/data/api/api_service.dart';
import 'package:firstffasubmission/utility/notification_helper.dart';

import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static const String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getRestaurants();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
