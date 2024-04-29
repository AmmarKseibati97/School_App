// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StudentModel',
      json,
      ($checkedConvert) {
        final val = StudentModel(
          uid: $checkedConvert('uid', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          checkStatus: $checkedConvert('check_status', (v) => v as String),
          checkedInAt: $checkedConvert('checked_in_at', (v) => v as String),
          checkedOutAt: $checkedConvert('checked_out_at', (v) => v as String),
          leaveAt: $checkedConvert('absence_at', (v) => v as String),
          absenceDates: $checkedConvert('absence_dates',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'checkStatus': 'check_status',
        'checkedInAt': 'checked_in_at',
        'checkedOutAt': 'checked_out_at',
        'leaveAt': 'absence_at',
        'absenceDates': 'absence_dates'
      },
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'check_status': instance.checkStatus,
      'checked_in_at': instance.checkedInAt,
      'checked_out_at': instance.checkedOutAt,
      'absence_at': instance.leaveAt,
      'absence_dates': instance.absenceDates,
    };
