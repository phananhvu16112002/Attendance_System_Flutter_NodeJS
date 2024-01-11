import 'package:attendance_system_nodejs/screens/TestSocket3.dart';
import 'package:attendance_system_nodejs/services/SocketServer.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TestSocket extends StatefulWidget {
  const TestSocket({super.key});

  @override
  State<TestSocket> createState() => _TestSocketState();
}

class _TestSocketState extends State<TestSocket> {
  late SocketServer socketServer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketServer = SocketServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => TestSocket3(classes: "1")));
            print('tap');
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 410,
            color: Colors.amber,
            child: const Center(
              child: Text(
                'Click',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
