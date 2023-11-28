import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var accessTokenDatabase;

  Future<String> getAccessTokenDatabase() async {
    return await SecureStorage().readSecureData("accessToken");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      accessTokenDatabase = getAccessTokenDatabase();
    });
  }

  @override
  void dispose(){
    print("Home Page dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentDataProvider = Provider.of<StudentDataProvider>(context);
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<String>(
        future: accessTokenDatabase,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != "No Data Found"){
            studentDataProvider.setAccessToken(snapshot.data!);
            return Text(snapshot.data!);

          }else if (studentDataProvider.userData.accessToken.isNotEmpty){
            return Text(studentDataProvider.userData.accessToken);

          }else if (snapshot.data == "No Data Found" && studentDataProvider.userData.accessToken == ""){
            return const WelcomePage();
          }
          return const CircularProgressIndicator();
        }
        )
      ) 
    );
  }
}
