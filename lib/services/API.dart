import 'dart:convert';
import 'package:attendance_system_nodejs/models/AttendanceDetail.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class API {
  Future<List<StudentClasses>> getStudentClass(String studentID) async {
    final URL = 'http://10.0.2.2:8080/test/testGetClassesVersion1'; //10.0.2.2
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    var request = {'studentID': studentID};
    var json = jsonEncode(request);
    try {
      final response =
          await http.post(Uri.parse(URL), headers: headers, body: json);
      if (response.statusCode == 200) {
        print('Respone.body ${response.body}');
        print('JsonDecode:${jsonDecode(response.body)}');
        List studentClassesList = jsonDecode(response.body);
        List<StudentClasses> data = [];
        for (var temp in studentClassesList) {
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

  Future<List<AttendanceDetail>> getAttendanceDetail(String classesID) async {
    final URL = 'http://10.0.2.2:8080/test/getAttendanceDetail'; //10.0.2.2
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    try {
      final response = await http.get(Uri.parse(URL), headers: headers);
      if (response.statusCode == 200) {
        List attendanceDetailList = jsonDecode(response.body);
        List<AttendanceDetail> data = [];
        for (var temp in attendanceDetailList) {
          if (temp is Map<String, dynamic>) {
            if (temp['classes'] == classesID) {
              try {
                data.add(AttendanceDetail.fromJson(temp));
              } catch (e) {
                print('Error parsing data: $e');
              }
            }
          } else {
            print('Invalid data type: $temp');
          }
        }
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

  Future<bool> takeAttendance(
      String studentID, String classID, String formID, XFile fileImage) async {
    const URL = 'http://10.0.2.2:8080/api/student/takeAttendance';
    final headers = {
      'Content-type': 'multipart/form-data',
    };
    var imageBytes = await fileImage.readAsBytes();
    var imageFile =
        http.MultipartFile.fromBytes('file', imageBytes, filename: 'image.jpg');
    var request = await http.MultipartRequest('POST', Uri.parse(URL))
      ..fields['studentID'] = studentID
      ..fields['classID'] = classID
      ..fields['formID'] = formID
      ..files.add(imageFile);
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Take Attendance Successfully');
        return true;
      } else if (response.statusCode == 403) {
        Map<String, dynamic> data =
            json.decode(await response.stream.bytesToString());
        String message = data['message'];
        print('Failed to take attendance: $message');
        return false;
      } else {
        // Handle other status codes
        print('Failed to take attendance. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error sending request: $e');
      return false;
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
