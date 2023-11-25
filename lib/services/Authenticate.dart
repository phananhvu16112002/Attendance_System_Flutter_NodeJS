import 'dart:convert';
import 'package:http/http.dart' as http;

class Authenticate {
  Future<void> registerUser(
      String userName, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/student/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'username': userName,
        'email': email,
        'password': password
      }),
    );
    if (response.statusCode == 200) {
      print('Registration successful');
    } else {
      print('Failed to register. Error: ${response.body}');
    }
  }

  Future<bool> verifyOTP(String email, String OTP) async {
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/student/verifyRegister'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'email': email, 'OTP': OTP}));

    if (response.statusCode == 200) {
      print('Registration successful');
      return true;
    } else {
      print('Failed to register. Error: ${response.body}');
      return false;
    }
  }

  Future<void> login(String email, String OTP) async {}

  Future<void> forgotPassword(String email) async {}

  Future<void> verifyForgotPassword(String email,String OTP) async {}

  Future<void> resetPassword(String email, String newPassword) async {}
}
