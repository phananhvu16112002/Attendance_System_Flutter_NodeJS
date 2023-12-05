import 'package:attendance_system_nodejs/models/Class.dart';

class StudentClasses {
  final String student;
  final Class classes;
  final int presenceTotal;
  final int lateTotal;
  final int absenceTotal;

  StudentClasses({
    required this.student,
    required this.classes,
    required this.presenceTotal,
    required this.lateTotal,
    required this.absenceTotal,
  });
  factory StudentClasses.fromJson(Map<String, dynamic> json) {
    print('StudentClasses.fromJson: $json');
    return StudentClasses(
      student: json['student'] ?? "",
      classes: Class.fromJson(json['classes'] ?? {}),
      presenceTotal: json['presenceTotal'] ?? 0,
      lateTotal: json['lateTotal'] ?? 0,
      absenceTotal: json['absenceTotal'] ?? 0,
    );
  }
}
