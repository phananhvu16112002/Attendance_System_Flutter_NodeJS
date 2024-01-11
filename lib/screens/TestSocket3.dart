import 'package:attendance_system_nodejs/services/SocketServer.dart';
import 'package:flutter/material.dart';

class TestSocket3 extends StatefulWidget {
  const TestSocket3({super.key, required this.classes});
  final String classes;

  @override
  State<TestSocket3> createState() => _TestSocket3State();
}

class _TestSocket3State extends State<TestSocket3> {
  late SocketServer socketServer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketServer = SocketServer();
    socketServer.connectToSocketServer("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                socketServer.disconnectSocketServer();
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back))),
    );
  }
}
