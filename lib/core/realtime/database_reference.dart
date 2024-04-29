class DatabaseReference {
  static var today = DateTime.now().toIso8601String().split('T').first;
  static const students = 'students';
  static String userTeacherInfo(String uid) => 'teachers/$uid';
  static String checkStudent(String uid) => 'students/$uid';
  static String absenseStudent = 'absences/$today';
}
