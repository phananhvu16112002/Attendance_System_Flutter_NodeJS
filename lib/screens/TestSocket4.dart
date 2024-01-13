import 'package:attendance_system_nodejs/providers/socketServer_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestSocket4 extends StatefulWidget {
  const TestSocket4({super.key});

  @override
  State<TestSocket4> createState() => _TestSocket4State();
}

class _TestSocket4State extends State<TestSocket4> {
  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketServerProvider>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              socketProvider.disconnectSocketServer();
              print('Disconected');
            },
            child: Text('Click')),
      ),
    );
  }
}
