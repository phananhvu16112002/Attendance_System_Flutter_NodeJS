import 'package:attendance_system_nodejs/models/Class.dart';
import 'package:attendance_system_nodejs/models/Student.dart';

class StudentClasses {
  Student student;
  Class classes;
  int progress;
  int total;
  double totalPresence;
  double totalAbsence;
  double totalLate;

  StudentClasses({
    required this.student,
    required this.classes,
    required this.progress,
    required this.total,
    required this.totalPresence,
    required this.totalAbsence,
    required this.totalLate,
  });
  factory StudentClasses.fromJson(Map<String, dynamic> json) {
    print('StudentClasses.fromJson: $json');

    return StudentClasses(
      student: json['studentDetail'],
      classes: json['classDetail'],
      progress: json['progress'] ?? 0,
      total: json['total'] ?? 0,
      totalPresence: json['totalPresence'] ?? 0.0,
      totalAbsence: json['totalAbsence'] ?? 0.0,
      totalLate: json['totalLate'] ?? 0.0,
    );
  }
}
