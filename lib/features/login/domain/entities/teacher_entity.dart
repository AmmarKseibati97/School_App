import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

abstract class TeacherEntity extends Equatable {
  @JsonKey(
    name: TeacherKeys.uid,
    includeToJson: true,
  )
  final String uid;
  @JsonKey(name: TeacherKeys.email)
  final String email;
  @JsonKey(name: TeacherKeys.name)
  final String name;

  const TeacherEntity({
    required this.uid,
    required this.name,
    required this.email,
  });
}

class TeacherKeys {
  static const String uid = 'uid';
  static const String name = 'name';
  static const String email = 'email';
}
