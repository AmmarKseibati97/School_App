import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class StudentEntity extends Equatable {
  @JsonKey(name: StudentKeys.uid)
  final String uid;
  @JsonKey(name: StudentKeys.name)
  final String name;
  @JsonKey(name: StudentKeys.checkStatus)
  final String checkStatus;
  @JsonKey(name: StudentKeys.checkedInAt)
  final String checkedInAt;
  @JsonKey(name: StudentKeys.checkedOutAt)
  final String checkedOutAt;
  @JsonKey(name: StudentKeys.leaveAt)
  final String leaveAt;

  @JsonKey(name: StudentKeys.absenceDates)
  final List<String> absenceDates;

  const StudentEntity({
    required this.uid,
    required this.name,
    required this.checkStatus,
    required this.checkedInAt,
    required this.checkedOutAt,
    required this.leaveAt,
    required this.absenceDates,
  });
}

class StudentKeys {
  static const String uid = 'uid';
  static const String name = 'name';
  static const String checkStatus = 'check_status';
  static const String checkedInAt = 'checked_in_at';
  static const String checkedOutAt = 'checked_out_at';
  static const String leaveAt = 'absence_at';
  static const String absenceDates = 'absence_dates';
}
