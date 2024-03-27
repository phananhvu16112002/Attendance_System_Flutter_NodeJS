class ReportModel {
  String classesClassID;
  String classesRoomNumber;
  int classesShiftNumber;
  String classesStartTime;
  String classesEndTime;
  String classesClassType;
  String classesGroup;
  String classesSubGroup;
  String classesCourseID;
  String classesTeacherID;
  String courseCourseID;
  String courseCourseName;
  int? courseTotalWeeks;
  int? courseRequiredWeeks;
  int? courseCredit;
  int? feedbackFeedbackID;
  String feedbackTopic;
  String feedbackMessage;
  String feedbackConfirmStatus;
  String feedbackCreatedAt;
  int feedbackReportID;
  int reportID;
  String topic;
  String problem;
  String message;
  String status;
  String createdAt;
  int isNew;
  int isImportant;
  String studentID;
  String classID;
  String formID;
  String teacherID;
  String teacherEmail;
  String teacherName;

  ReportModel({
    required this.classesClassID,
    required this.classesRoomNumber,
    required this.classesShiftNumber,
    required this.classesStartTime,
    required this.classesEndTime,
    required this.classesClassType,
    required this.classesGroup,
    required this.classesSubGroup,
    required this.classesCourseID,
    required this.classesTeacherID,
    required this.courseCourseID,
    required this.courseCourseName,
    required this.courseTotalWeeks,
    required this.courseRequiredWeeks,
    required this.courseCredit,
    required this.feedbackFeedbackID,
    required this.feedbackTopic,
    required this.feedbackMessage,
    required this.feedbackConfirmStatus,
    required this.feedbackCreatedAt,
    required this.feedbackReportID,
    required this.reportID,
    required this.topic,
    required this.problem,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.isNew,
    required this.isImportant,
    required this.studentID,
    required this.classID,
    required this.formID,
    required this.teacherID,
    required this.teacherEmail,
    required this.teacherName,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      classesClassID: json['classes_classID'] ?? '',
      classesRoomNumber: json['classes_roomNumber'] ?? '',
      classesShiftNumber: int.parse(json['classes_shiftNumber']) ?? 0,
      classesStartTime: json['classes_startTime'] ?? '',
      classesEndTime: json['classes_endTime'] ?? '',
      classesClassType: json['classes_classType'] ?? '',
      classesGroup: json['classes_group'] ?? '',
      classesSubGroup: json['classes_subGroup'] ?? '',
      classesCourseID: json['classes_courseID'] ?? '',
      classesTeacherID: json['classes_teacherID'] ?? '',
      courseCourseID: json['course_courseID'] ?? '',
      courseCourseName: json['course_courseName'] ?? '',
      courseTotalWeeks: int.parse(json['course_totalWeeks'].toString()) ?? 0,
      courseRequiredWeeks:
          int.parse(json['course_requiredWeeks'].toString()) ?? 0,
      courseCredit: int.parse(json['course_credit'].toString()) ?? 0,
      feedbackFeedbackID:
          int.parse(json['feedback_feedbackID'].toString()) ?? 0,
      feedbackTopic: json['feedback_topic'] ?? '',
      feedbackMessage: json['feedback_message'] ?? '',
      feedbackConfirmStatus: json['feedback_confirmStatus'] ?? '',
      feedbackCreatedAt: json['feedback_createdAt'] ?? '',
      feedbackReportID: int.parse(json['feedback_reportID'].toString()) ?? 0,
      reportID: int.parse(json['reportID'].toString()) ?? 0,
      topic: json['topic'] ?? '',
      problem: json['problem'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      isNew: int.parse(json['new'].toString()) ?? 0,
      isImportant: int.parse(json['important'].toString()) ?? 0,
      studentID: json['studentID'] ?? '',
      classID: json['classID'] ?? '',
      formID: json['formID'] ?? '',
      teacherID: json['teacherID'] ?? '',
      teacherEmail: json['teacherEmail'] ?? '',
      teacherName: json['teacherName'] ?? '',
    );
  }
}
