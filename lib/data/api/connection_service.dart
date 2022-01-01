import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class DataService {
  bool connected;
  String message;
  // DataConnectionStatus dataConnectionStatus;
  DataService({
     this.message,
     this.connected,
    // this.dataConnectionStatus,
  });
}

class ConnectionService {
  Future<DataService> connectionService(BuildContext context) async {
    bool connected;
    String message = '';
    final connection = await DataConnectionChecker().connectionStatus;
    if (connection == DataConnectionStatus.connected) {
      connected = true;
    } else {
      connected = false;
      message = 'Disconnected, Hubungkan ke internet';
    }
    return DataService(connected: connected, message: message);
  }
}
