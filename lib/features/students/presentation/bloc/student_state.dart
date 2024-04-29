part of 'student_bloc.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState.initial() = _Initial;
  const factory StudentState.loading() = _Loading;
  const factory StudentState.failure({
    @Default(null) Failure? failure,
  }) = _Failure;
  const factory StudentState.empty() = _Empty;
  const factory StudentState.studentsFetched({
    @Default([]) List<StudentEntity> students,
  }) = _StudentStateFetched;

  const factory StudentState.statusCheked({
    @Default([]) List<StudentEntity> students,
  }) = _StudentStateStatusCheked;

  // absences
  const factory StudentState.absencesLoading() = _AbsencesLoading;
  const factory StudentState.absencesFailure({
    @Default(null) Failure? failure,
  }) = _AbsencesFailure;
  const factory StudentState.absencesEmpty() = _AbsencesEmpty;
  const factory StudentState.absencesFetched({
    @Default([]) List<StudentEntity> absences,
  }) = _AbsencesStudentStateFetched;
}
