import 'package:attendance_system_nodejs/models/Class.dart';
import 'package:attendance_system_nodejs/models/Course.dart';
import 'package:attendance_system_nodejs/models/Student.dart';
import 'package:attendance_system_nodejs/models/Teacher.dart';

class StudentClasses {
  Student studentID;
  Class classes;
  double progress;
  double total;
  double totalPresence;
  double totalAbsence;
  double totalLate;

  StudentClasses({
    required this.studentID,
    required this.classes,
    required this.progress,
    required this.total,
    required this.totalPresence,
    required this.totalAbsence,
    required this.totalLate,
  });
  factory StudentClasses.fromJson(Map<String, dynamic> json) {
    print('StudentClasses.fromJson: $json');

    final dynamic studentJson = json['studentDetail'];
    final Student studentDetail = studentJson is String
        ? Student(
            studentID: studentJson,
            studentName: '',
            studentEmail: '',
            password: '',
            hashedOTP: '',
            accessToken: '',
            refreshToken: '',
            active: true,
            latitude: 0.0,
            longtitude: 0.0,
            location: '')
        : Student.fromJson(studentJson ?? {});

    final dynamic classJson = json['classDetail'];
    final Class classDetail = classJson is String
        ? Class(
            classID: classJson,
            roomNumber: '',
            shiftNumber: 0,
            startTime: '',
            endTime: '',
            classType: '',
            group: '',
            subGroup: '',
            teacher: Teacher(
                teacherID: '',
                teacherName: '',
                teacherHashedPassword: '',
                teacherEmail: '',
                teacherHashedOTP: '',
                timeToLiveOTP: '',
                accessToken: '',
                refreshToken: '',
                resetToken: '',
                active: true),
            course: Course(
                courseID: '',
                courseName: '',
                totalWeeks: 10,
                requiredWeeks: 3,
                credit: 3))
        : Class.fromJson(classJson ?? {});
    print(json['total'].runtimeType);
    return StudentClasses(
      studentID: studentDetail,
      classes: classDetail,
      progress: json['progress'] ?? 0.0,
      total: double.tryParse(json['total'].toString())  ?? 0.0,
      totalPresence: double.tryParse(json['totalPresence']) ?? 0.0,
      totalAbsence: double.tryParse(json['totalAbsence']) ?? 0.0,
      totalLate: double.tryParse(json['totalLate']) ?? 0.0,
    );
  }
}
