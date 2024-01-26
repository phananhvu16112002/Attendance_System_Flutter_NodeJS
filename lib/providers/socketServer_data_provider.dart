import 'dart:convert';

import 'package:attendance_system_nodejs/models/AttendanceDetail.dart';
import 'package:attendance_system_nodejs/models/AttendanceForm.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class SocketServerProvider with ChangeNotifier {
  late IO.Socket _socket;
  bool _isConnected = false;

  IO.Socket get socket => _socket;
  bool get isConnected => _isConnected;

  final StreamController<AttendanceForm> _attendanceFormController =
      StreamController<AttendanceForm>.broadcast();

  Stream<AttendanceForm> get attendanceFormStream =>
      _attendanceFormController.stream.asBroadcastStream();

  @override
  void dispose() {
    // TODO: implement dispose
    _attendanceFormController.close();
    print('socket dispose');
    super.dispose();
  }

  void connectToSocketServer(data) {
    _socket = IO.io('http://localhost:9000', <String, dynamic>{
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

  AttendanceForm? getAttendanceForm(classRoom) {
    _socket.on('getAttendanceForm', (data) {
      var temp = jsonDecode(data);
      var temp1 = temp['classes'];
      if (temp1 == classRoom) {
        print('Attendance Form Detail:' + data);
        _attendanceFormController.add(AttendanceForm.fromJson(temp));
        AttendanceForm attendanceForm = AttendanceForm.fromJson(temp);
        return attendanceForm;
      } else {
        print('Error ClassRoom not feat');
        return null;
      }
    });
    return null;
  }

  void disconnectSocketServer() {
    _socket.disconnect();
    _isConnected = false;
    notifyListeners();
  }
}
