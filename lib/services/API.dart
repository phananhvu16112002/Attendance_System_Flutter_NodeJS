import 'dart:convert';
import 'package:attendance_system_nodejs/models/AttendanceDetail.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:attendance_system_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class API {
  BuildContext context;
  API(this.context);

  Future<String> getAccessToken() async {
    SecureStorage secureStorage = SecureStorage();
    var accessToken = await secureStorage.readSecureData('accessToken');
    return accessToken;
  }

  Future<String> refreshAccessToken(String refreshToken) async {
    const url = 'http://192.168.1.5:8080/api/token/refreshAccessToken';
    var headers = {'authorization': refreshToken};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print('Create New AccessToken is successfully');
        var newAccessToken = jsonDecode(response.body)['accessToken'];
        return newAccessToken;
      } else if (response.statusCode == 401) {
        print('Refresh Token is expired'); // Navigation to welcomePage
        await SecureStorage().deleteSecureData('refreshToken');
        await SecureStorage().deleteSecureData('accessToken');
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                // Navigate to WelcomePage when dialog is dismissed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
                return true; // Return true to allow pop
              },
              child: AlertDialog(
                backgroundColor: Colors.white,
                elevation: 0.5,
                title: const Text('Unauthorized'),
                content: const Text(
                    'Your session has expired. Please log in again.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ),
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
        );
        return '';
      } else if (response.statusCode == 498) {
        print('Refresh Token is invalid');
        return '';
      } else {
        print(
            'Failed to refresh accessToken. Status code: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error234: $e');
      return '';
    }
  }

  Future<List<StudentClasses>> getStudentClass() async {
    const URL =
        'http://192.168.1.5:8080/api/student/getStudentClasses'; //10.0.2.2

    var accessToken = await getAccessToken();
    var headers = {'authorization': accessToken};
    try {
      final response = await http.get(Uri.parse(URL), headers: headers);
      if (response.statusCode == 200) {
        print('Response.body ${response.body}');
        print('JsonDecode:${jsonDecode(response.body)}');
        dynamic responseData = jsonDecode(response.body);
        List<StudentClasses> data = [];

        if (responseData is List) {
          for (var temp in responseData) {
            if (temp is Map<String, dynamic>) {
              try {
                data.add(StudentClasses.fromJson(temp));
              } catch (e) {
                print('Error parsing data: $e');
              }
            } else {
              print('Invalid data type: $temp');
            }
          }
        } else if (responseData is Map<String, dynamic>) {
          try {
            data.add(StudentClasses.fromJson(responseData));
          } catch (e) {
            print('Error parsing data: $e');
          }
        } else {
          print('Unexpected data type: $responseData');
        }
        print('Data $data');
        return data;
      } else if (response.statusCode == 498 || response.statusCode == 401) {
        print('Status code: ${response.statusCode}');
        var refreshToken = await SecureStorage().readSecureData('refreshToken');
        var newAccessToken = await refreshAccessToken(refreshToken);
        if (newAccessToken.isNotEmpty) {
          headers['authorization'] = newAccessToken;
          final retryResponse =
              await http.get(Uri.parse(URL), headers: headers);
          if (retryResponse.statusCode == 200) {
            print('-- RetryResponse.body ${retryResponse.body}');
            print('-- Retry JsonDecode:${jsonDecode(retryResponse.body)}');
            dynamic responseData = jsonDecode(retryResponse.body);
            List<StudentClasses> data = [];

            if (responseData is List) {
              for (var temp in responseData) {
                if (temp is Map<String, dynamic>) {
                  try {
                    data.add(StudentClasses.fromJson(temp));
                  } catch (e) {
                    print('Error parsing data: $e');
                  }
                } else {
                  print('Invalid data type: $temp');
                }
              }
            } else if (responseData is Map<String, dynamic>) {
              try {
                data.add(StudentClasses.fromJson(responseData));
              } catch (e) {
                print('Error parsing data: $e');
              }
            } else {
              print('Unexpected data type: $responseData');
            }

            print('Data $data');
            return data;
          } else {
            return [];
          }
        } else {
          print('New Access Token is empty');
          return [];
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<AttendanceDetail>> getAttendanceDetail(
      String classesID, String studentID) async {
    final URL =
        'http://192.168.1.5:8080/test/testGetAttendanceDetailVersion1'; //10.0.2.2
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    var request = {'classesID': classesID, 'studentID': studentID};
    var body = jsonEncode(request);
    try {
      final response =
          await http.post(Uri.parse(URL), headers: headers, body: body);
      // print('Respone.body ${response.body}');
      // print('JsonDecode:${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        List attendanceDetailList = jsonDecode(response.body);
        List<AttendanceDetail> data = [];
        for (var temp in attendanceDetailList) {
          if (temp is Map<String, dynamic>) {
            if (temp['classDetail'] == classesID) {
              try {
                data.add(AttendanceDetail.fromJson(temp));
              } catch (e) {
                print('Error parsing data: $e');
              }
            }
          } else {
            print('Invalid data type: $temp');
          }
          // try {
          //   data.add(AttendanceDetail.fromJson(temp));
          // } catch (e) {
          //   print('Error parsing data: $e');
          // }
        }
        print('Data ${data}');

        return data;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<AttendanceDetail?> takeAttendance(
      String studentID,
      String classID,
      String formID,
      String dateAttendance,
      String location,
      double latitude,
      double longitude,
      XFile fileImage) async {
    const URL = 'http://192.168.1.5:8080/api/student/takeAttendance';
    final headers = {
      'Content-type': 'multipart/form-data',
    };
    var imageBytes = await fileImage.readAsBytes();
    var imageFile =
        http.MultipartFile.fromBytes('file', imageBytes, filename: 'image.jpg');
    var request = http.MultipartRequest('POST', Uri.parse(URL))
      ..fields['studentID'] = studentID
      ..fields['classID'] = classID
      ..fields['formID'] = formID
      ..fields['dateTimeAttendance'] = dateAttendance
      ..fields['location'] = location
      ..fields['latitude'] = latitude.toString()
      ..fields['longitude'] = longitude.toString()
      ..files.add(imageFile);
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Take Attendance Successfully');
        Map<String, dynamic> data =
            json.decode(await response.stream.bytesToString());
        AttendanceDetail attendanceDetail = AttendanceDetail.fromJson(data);
        print('data:$data');
        return attendanceDetail;
      } else if (response.statusCode == 403) {
        Map<String, dynamic> data =
            json.decode(await response.stream.bytesToString());
        String message = data['message'];
        print('Failed to take attendance: $message');
        return null;
      } else {
        print('Failed to take attendance. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error sending request: $e');
      return null;
    }
  }
}

// if (response.statusCode == 200) {
//   print('Take Attendance Successfully');
//   return true;
// } else if (response.statusCode == 403) {
//   // Handle status 403 - Forbidden
//   Map<String, dynamic> data = json.decode(response.body);
//   String message = data['message'];
//   print('Failed to take attendance: $message');
//   return false;
// } else {
//   // Handle other status codes
//   print('Failed to take attendance. Status code: ${response.statusCode}');
//   return false;
// }
