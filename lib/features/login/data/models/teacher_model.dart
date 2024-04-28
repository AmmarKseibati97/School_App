import 'package:a_school_app/core/models/base_model.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'teacher_model.g.dart';

@JsonSerializable(
  checked: true,
)
class TeacherModel extends TeacherEntity implements Model {
  const TeacherModel({
    required super.uid,
    required super.name,
    required super.email,
  });

  @override
  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);

  @override
  List<Object> get props => [
        uid,
        name,
        email,
      ];
}
