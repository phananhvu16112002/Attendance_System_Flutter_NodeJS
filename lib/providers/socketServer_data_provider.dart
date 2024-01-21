import 'dart:convert';

import 'package:attendance_system_nodejs/models/AttendanceForm.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketServerProvider with ChangeNotifier {
  late IO.Socket _socket;
  bool _isConnected = false;
  late AttendanceForm _attendanceForm;

  IO.Socket get socket => _socket;
  bool get isConnected => _isConnected;
  AttendanceForm get attendanceForm => _attendanceForm;

  void connectToSocketServer(data) {
    _socket = IO.io('http://192.168.0.106:9000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'headers': {'Content-Type': 'application/json'},
    });

    _socket.connect();
    _isConnected = true;
    joinClassRoom(data);
    _attendanceForm = getAttendanceForm(data)!;
    notifyListeners();
  }

  void joinClassRoom(data) {
    var jsonData = {'classRoom': data};
    var jsonString = jsonEncode(jsonData);
    print("Sending joinClassRoom event with data: $jsonString");
    _socket.emit('joinClassRoom', jsonString);
  }

  AttendanceForm? getAttendanceForm(classRoom) {
    _socket.on('getAttendanceForm', (data) {
      var temp = jsonDecode(data);
      var temp1 = temp['classes'];
      if (temp1 == classRoom) {
        print('Attendance Form Detail:' + data);
        AttendanceForm tempAttendanceForm = AttendanceForm.fromJson(temp);
        notifyListeners();
        return tempAttendanceForm;
      } else {
        print('Error ClassRoom not feat');
        return null;
      }
    });
  }

  void disconnectSocketServer() {
    _socket.disconnect();
    _isConnected = false;
    notifyListeners();
  }
}
