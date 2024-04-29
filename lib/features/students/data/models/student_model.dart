import 'package:a_school_app/core/models/base_model.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';

@JsonSerializable(
  checked: true,
)
class StudentModel extends StudentEntity implements Model {
  const StudentModel({
    required super.uid,
    required super.name,
    required super.checkStatus,
    required super.checkedInAt,
    required super.checkedOutAt,
    required super.leaveAt,
    required super.absenceDates,
  });

  @override
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  @override
  List<Object> get props => [
        uid,
        name,
        checkStatus,
        checkedInAt,
        checkedOutAt,
        leaveAt,
      ];
}
