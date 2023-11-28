import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';

class Authenticate {
  Future<void> registerUser(
      String userName, String email, String password) async {
    final URL = 'http://10.0.2.2:8080/api/student/register';
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    var request = {'email': email, 'password': password, 'username': userName};
    var body = json.encode(request);
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response);
      print(response.body);
      print('Registration successful');
    } else {
      print('Failed to register. Error: ${response.body}');
    }
  }

  Future<bool> verifyOTP(String email, String otp) async {
    final URL = 'http://10.0.2.2:8080/api/student/verifyRegister';
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    var request = {'email': email, 'OTP': otp};
    var body = json.encode(request);
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Registration successful');
      print(response);
      print(response.body);
      return true;
    } else {
      print('Failed to register. Error: ${response.body}');
      return false;
    }
  }

  Future<void> login(String email, String password) async {
    final URL = 'http://10.0.2.2:8080/api/student/login';
    var request = {'email': email, 'password': password};
    var body = json.encode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String accessToken = jsonDecode(response.body)['accessToken'];
      final String refreshToken = jsonDecode(response.body)['refreshToken'];
      final aToken =
          await SecureStorage().writeSecureData('accessToken', accessToken);
      final rToken =
          await SecureStorage().writeSecureData('refreshToken', refreshToken);
    }
  }

  Future<void> forgotPassword(String email) async {}

  Future<void> verifyForgotPassword(String email, String otp) async {}

  Future<void> resetPassword(String email, String newPassword) async {}
}
