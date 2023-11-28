import 'dart:convert';
import 'package:http/http.dart' as http;
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
      return true;
    } else {
      print('Failed to register. Error: ${response.body}');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
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
      var accessToken = responseData['refreshToken'];
      var refreshToken = responseData['accessToken'];

      await SecureStorage().writeSecureData('accessToken', accessToken);
      await SecureStorage().writeSecureData('refreshToken', refreshToken);
      return true;
    } else {
      // ignore: avoid_print
      print('User is not exist');
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    final URL = 'http://10.0.2.2:8080/api/student/forgotPassword';
    var request = {'email': email};
    var body = jsonEncode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Successfully...');
      return true;
    } else {
      print('Failed');
      return false;
    }
  }

  Future<bool> verifyForgotPassword(String email, String otp) async {
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/student/verifyForgotPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'email': email, 'OTP': otp}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      var resetToken = responseData['resetToken'];
      await SecureStorage().writeSecureData('resetToken', resetToken);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    final resetToken = await SecureStorage().readSecureData("resetToken");
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/student/resetPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'authorization': resetToken
        },
        body: jsonEncode(
            <String, String>{'email': email, 'newPassword': newPassword}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resendOTP(String email) async {
    final URL = 'http://10.0.2.2:8080/api/student/resendOTP';
    var request = {'email': email};
    var body = jsonEncode(request);
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final response =
        await http.post(Uri.parse(URL), headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Successfully...');
      return true;
    } else {
      print('Failed');
      return false;
    }
  }
}
