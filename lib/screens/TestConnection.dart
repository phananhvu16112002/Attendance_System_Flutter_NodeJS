import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class TestConnection extends StatefulWidget {
  const TestConnection({super.key});

  @override
  State<TestConnection> createState() => _TestConnectionState();
}

class _TestConnectionState extends State<TestConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Connection'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
              print(snapshot.toString());
              if (snapshot.hasData) {
                ConnectivityResult? result = snapshot.data;
                if (result == ConnectivityResult.mobile) {
                  return connected('Mobile');
                } else if (result == ConnectivityResult.wifi) {
                  return connected('Wifi');
                } else {
                  return connected('No internet');
                }
              } else {
                return loading();
              }
            }),
      ),
    );
  }

  Widget loading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.green),
      ),
    );
  }

  Widget connected(String type) {
    return Center(
      child: Text(
        '$type connected',
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
