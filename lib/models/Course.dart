class Course {
  final String courseID;
  final String courseName;
  final int totalWeeks;
  final int requiredWeeks;
  final int credit;

  Course({
    required this.courseID,
    required this.courseName,
    required this.totalWeeks,
    required this.requiredWeeks,
    required this.credit,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        courseID: json['courseID'] ?? "",
        courseName: json['courseName'] ?? "",
        totalWeeks: int.tryParse(json['totalWeeks'].toString()) ?? 0,
        requiredWeeks: int.tryParse(json['requiredWeeks'].toString()) ?? 0,
        credit: int.tryParse(json['credit'].toString()) ?? 0);
  }
}
