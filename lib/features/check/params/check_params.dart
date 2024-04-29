class CheckParams {
  final String uid;
  final String check;
  final String? date;

  CheckParams({
    required this.uid,
    required this.check,
    this.date,
  });
  final String dateTime = DateTime.now().toIso8601String();

  Map<String, dynamic> checkInToMap() {
    return {
      'checked_in_at': dateTime,
      'check_status': check,
      'absence_at': 'init',
    };
  }

  Map<String, dynamic> checkOutToMap() {
    return {
      'checked_out_at': dateTime,
      'check_status': check,
      'absence_at': 'init',
    };
  }

  Map<String, dynamic> absenceToMap() {
    return {
      'absence_at': dateTime,
      'check_status': check,
    };
  }
}
