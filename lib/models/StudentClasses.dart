import 'package:attendance_system_nodejs/models/Class.dart';
import 'package:attendance_system_nodejs/models/Course.dart';
import 'package:attendance_system_nodejs/models/Teacher.dart';

class StudentClasses {
  String studentID;
  Class classes;
  int presenceTotal;
  int lateTotal;
  int absenceTotal;

  StudentClasses({
    required this.studentID,
    required this.classes,
    required this.presenceTotal,
    required this.lateTotal,
    required this.absenceTotal,
  });
  factory StudentClasses.fromJson(Map<String, dynamic> json) {
    print('StudentClasses.fromJson: $json');

    final dynamic classesJson = json['classesID'];
    final Class classes = classesJson is String
        ? Class(
            classID: classesJson,
            roomNumber: "",
            shiftNumber: 0,
            startTime: "",
            endTime: "",
            classType: "",
            group: "",
            subGroup: "",
            teacher: Teacher(
                teacherID: "",
                teacherName: "",
                teacherHashedPassword: "",
                teacherEmail: "",
                teacherHashedOTP: "",
                timeToLiveOTP: "",
                accessToken: "",
                refreshToken: "",
                resetToken: "",
                active: false),
            course: Course(
                courseID: "",
                courseName: "",
                totalWeeks: 0,
                requiredWeeks: 0,
                credit: 0))
        : Class.fromJson(classesJson ?? {});
    return StudentClasses(
      studentID: json['studentID'] ?? "",
      classes: classes,
      presenceTotal: json['presenceTotal'] ?? 0,
      lateTotal: json['lateTotal'] ?? 0,
      absenceTotal: json['absenceTotal'] ?? 0,
    );
  }

  // factory StudentClasses.fromJson(Map<String, dynamic> json) {
  //   print('StudentClasses.fromJson: $json');
  //   if (json['classesID'] is Map<String, dynamic>) {
  //     return StudentClasses(
  //       studentID: json['studentID'] ?? "",
  //       classes: Class.fromJson(json['classesID']),
  //       presenceTotal: json['presenceTotal'] ?? 0,
  //       lateTotal: json['lateTotal'] ?? 0,
  //       absenceTotal: json['absenceTotal'] ?? 0,
  //     );
  //   } else {
  //     // Xử lý khi 'classesID' không phải là Map<String, dynamic>
  //     // Ví dụ: Trả về giá trị mặc định hoặc báo lỗi
  //     print("Error: 'classesID' is not of type Map<String, dynamic>");
  //     return StudentClasses(
  //       studentID: "",
  //       classes: Class(
  //         classID: "",
  //         roomNumber: "",
  //         shiftNumber: 0,
  //         startTime: null,
  //         endTime: null,
  //         classType: "",
  //         group: "",
  //         subGroup: "",
  //         teacher: Teacher(
  //           teacherID: "",
  //           teacherName: "",
  //           teacherEmail: "",
  //           teacherHashedPassword: '',
  //           teacherHashedOTP: '',
  //           timeToLiveOTP: '',
  //           accessToken: '',
  //           refreshToken: '',
  //           resetToken: '',
  //           active: false,
  //         ),
  //         course: Course(
  //           courseID: "",
  //           courseName: "",
  //           totalWeeks: 0,
  //           requiredWeeks: 0,
  //           credit: 0,
  //         ),
  //       ),
  //       presenceTotal: 0,
  //       lateTotal: 0,
  //       absenceTotal: 0,
  //     );
  //   }
  // }
}
