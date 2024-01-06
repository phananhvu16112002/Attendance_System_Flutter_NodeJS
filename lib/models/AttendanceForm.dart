import 'package:attendance_system_nodejs/models/Class.dart';

class AttendanceForm {
  String formID;
  Class classes;
  DateTime? startTime;
  DateTime? endTime;
  bool status;
  DateTime? date;
  int weekNumber;

  AttendanceForm({
    required this.formID,
    required this.classes,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.date,
    required this.weekNumber,
  });
}
