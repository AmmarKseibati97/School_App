class CheckParams {
  final String uid;
  final String check;

  CheckParams({
    required this.uid,
    required this.check,
  });
  final String dateTime = DateTime.now().toIso8601String();

  Map<String, dynamic> checkInToMap() {
    return {
      'checked_in_at': dateTime,
      'check_status': check,
      'checked_out_at': 'init',
      'leave_at': 'init',
    };
  }

  Map<String, dynamic> checkOutToMap() {
    return {
      'checked_out_at': dateTime,
      'check_status': check,
      'checked_in_at': 'init',
      'leave_at': 'init',
    };
  }

  Map<String, dynamic> leaveToMap() {
    return {
      'leave_at': dateTime,
      'check_status': check,
      'checked_in_at': 'init',
      'checked_out_at': 'init',
    };
  }
}
