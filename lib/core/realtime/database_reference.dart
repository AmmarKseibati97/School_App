class DatabaseReference {
  static var today = DateTime.now().toIso8601String().split('T').first;
  static const students = 'students';
  static var checksdetails = 'checks/$today';
  static String userTeacherInfo(String uid) => 'teachers/$uid';
  static String checkStudent(String uid) => 'students/$uid';
  static String checks(String uid) => 'checks/$today/$uid';
  static String absenseStudent(String uid) => 'students/$uid/absence_dates';
}
