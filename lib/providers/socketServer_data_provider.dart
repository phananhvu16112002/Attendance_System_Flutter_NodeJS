import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketServerProvider with ChangeNotifier {
  late IO.Socket _socket;
  bool _isConnected = false;

  IO.Socket get socket => _socket;
  bool get isConnected => _isConnected;

  void connectToSocketServer(data) {
    _socket = IO.io('http://192.168.1.4:9000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'headers': {'Content-Type': 'application/json'},
    });

    _socket.connect();
    _isConnected = true;
    joinClassRoom(data);
    getAttendanceForm(data);
    notifyListeners();
  }

  void joinClassRoom(data) {
    var jsonData = {'classRoom': data};
    var jsonString = jsonEncode(jsonData);
    print("Sending joinClassRoom event with data: $jsonString");
    _socket.emit('joinClassRoom', jsonString);
  }

  void getAttendanceForm(classRoom) {
    _socket.on('getAttendanceForm', (data) {
      var temp = jsonDecode(data);
      var temp1 = temp['classes'];
      if (temp1 == classRoom) {
        print('Attendance Form Detail:' + data);
      } else {
        print('Error ClassRoom not feat');
      }
    });
  }

  void disconnectSocketServer() {
    _socket.disconnect();
    _isConnected = false;
    notifyListeners();
  }
}
