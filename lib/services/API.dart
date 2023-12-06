import 'dart:convert';
import 'package:attendance_system_nodejs/models/AttendanceDetail.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:http/http.dart' as http;


class API {
  Future<List<StudentClasses>> getStudentClass() async {
    final URL = 'http://10.0.2.2:8080/test/getStudentClass';
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    try {
      final response = await http.get(Uri.parse(URL), headers: headers);
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

  Future<List<AttendanceDetail>> getAttendanceDetail() async {
    final URL = 'http://10.0.2.2:8080/test/getAttendanceDetail';
    var headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    try {
      final response = await http.get(Uri.parse(URL), headers: headers);
      if (response.statusCode == 200) {
        print('Respone.body ${response.body}');
        print('JsonDecode:${jsonDecode(response.body)}');
        List attendanceDetailList = jsonDecode(response.body);
        List<AttendanceDetail> data = [];
        for (var temp in attendanceDetailList) {
          if (temp is Map<String, dynamic>) {
            try {
              data.add(AttendanceDetail.fromJson(temp));
            } catch (e) {
              print('Error parsing data123: $e');
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
}
