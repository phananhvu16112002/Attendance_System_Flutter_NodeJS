import 'package:attendance_system_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = SecureStorage();
  String? accessToken;
  String? refreshToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    String? loadToken = await storage.readSecureData('accessToken');
    String? refreshToken1 = await storage.readSecureData('refreshToken');
    if (loadToken.isEmpty ||
        refreshToken1.isEmpty ||
        loadToken.contains('No Data Found') ||
        refreshToken1.contains('No Data Found')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    } else {
      setState(() {
        accessToken = loadToken;
        refreshToken = refreshToken1;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Text('AccessToken: ${accessToken ?? "N/A"}'),
        Text('RefreshToken: ${refreshToken ?? "N/A"}'),
        ElevatedButton(
            onPressed: () async {
              await SecureStorage().deleteSecureData('accessToken');
              await SecureStorage().deleteSecureData('refreshToken');
            },
            child: Text('Delete'))
      ],
    )));
  }
}
