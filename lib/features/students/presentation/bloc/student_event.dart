part of 'student_bloc.dart';

@freezed
class StudentEvent with _$StudentEvent {
  const factory StudentEvent.fetchStudents() = _FetchStudents;
  const factory StudentEvent.fetchChecks() = _FetchStudents;
  const factory StudentEvent.checkStudent({
    required CheckParams params,
  }) = _CheckStudent;

  const factory StudentEvent.fetchAbsences() = _FetchAbsences;
}
