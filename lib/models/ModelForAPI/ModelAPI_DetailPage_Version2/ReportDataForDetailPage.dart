import 'package:attendance_system_nodejs/models/ModelForAPI/ReportImage.dart';

class ReportData {
  int reportID;
  String topic;
  String problem;
  String message;
  String status;
  String createdAt;
  bool checkNew;
  bool important;
  List<ReportImage> reportImage;

  ReportData(
      {required this.reportID,
      required this.topic,
      required this.problem,
      required this.message,
      required this.status,
      required this.createdAt,
      required this.checkNew,
      required this.important,
      required this.reportImage});

  factory ReportData.fromJson(Map<String, dynamic> json) {
    List<dynamic> imagesJson = json['reportImage'] ?? [];
    List<ReportImage> reportImages =
        imagesJson.map((imageJson) => ReportImage.fromJson(imageJson)).toList();
    return ReportData(
      reportID: json['reportID'],
      topic: json['topic'],
      problem: json['problem'],
      message: json['message'],
      status: json['status'],
      createdAt: json['createdAt'],
      checkNew: json['new'],
      important: json['important'],
      reportImage: reportImages,
    );
  }
}
