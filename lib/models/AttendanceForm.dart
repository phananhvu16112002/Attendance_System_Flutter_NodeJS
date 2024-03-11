import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class AttendanceForm {
  @HiveField(0)
  String formID;

  @HiveField(0)
  String classes;

  @HiveField(0)
  String startTime;

  @HiveField(0)
  String endTime;

  @HiveField(0)
  String dateOpen;

  @HiveField(0)
  bool status;

  @HiveField(0)
  int typeAttendance;

  @HiveField(0)
  String location;

  @HiveField(0)
  double latitude;

  @HiveField(0)
  double longtitude;

  @HiveField(0)
  double radius;

  AttendanceForm({
    required this.formID,
    required this.classes,
    required this.startTime,
    required this.endTime,
    required this.dateOpen,
    required this.status,
    required this.typeAttendance,
    required this.location,
    required this.latitude,
    required this.longtitude,
    required this.radius,
  });

  factory AttendanceForm.fromJson(Map<String, dynamic> json) {
    print('AttendanceForm.fromJson: $json');
    return AttendanceForm(
        formID: json['formID'] ?? '',
        classes: json['classes'] ?? '',
        startTime: json['startTime'] ?? '',
        endTime: json['endTime'] ?? '',
        dateOpen: json['dateOpen'] ?? '',
        status: json['status'] ?? false,
        typeAttendance: json['type'] ?? 0,
        location: json['location'] ?? '',
        latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
        longtitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
        radius: double.tryParse(json['radius'].toString()) ?? 0.0);
  }
}
