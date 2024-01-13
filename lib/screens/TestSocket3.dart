import 'package:attendance_system_nodejs/providers/socketServer_data_provider.dart';
import 'package:attendance_system_nodejs/screens/TestSocket4.dart';
import 'package:attendance_system_nodejs/services/SocketServer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var socketProvider = Provider.of<SocketServerProvider>(context);
    socketProvider.connectToSocketServer("1");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => TestSocket4()));
              },
              child: const Icon(Icons.arrow_back))),
    );
  }
}
