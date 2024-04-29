import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/students/domain/use_cases/check_students_usecase.dart';
import 'package:a_school_app/features/check/params/check_params.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:a_school_app/features/students/domain/use_cases/fetch_students_usecase.dart';
import 'package:a_school_app/features/students/domain/use_cases/get_absense_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'student_state.dart';
part 'student_event.dart';
part 'student_bloc.freezed.dart';

@singleton
class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc({
    required this.fetchStudentsUseCase,
    required this.checkStudentsUseCase,
    required this.getAbsencesUseCase,
  }) : super(const StudentState.initial()) {
    on<StudentEvent>(
      (event, emit) async {
        await event.map(
          fetchStudents: (event) async => await _fetchStudents(event, emit),
          checkStudent: (event) async => await _checkStudent(event, emit),
          fetchAbsences: (event) async => await _fetchAbsences(event, emit),
        );
      },
    );
  }
  final List<StudentEntity> students = [];
  List<StudentEntity> absences = [];
  final FetchStudentsUseCase fetchStudentsUseCase;
  final CheckStudentsUseCase checkStudentsUseCase;
  final GetAbsencesUseCase getAbsencesUseCase;

  Future<void> _fetchStudents(
      StudentEvent event, Emitter<StudentState> emit) async {
    event as _$FetchStudentsImpl;
    emit(const StudentState.loading());
    final data = await fetchStudentsUseCase();
    data.fold(
      (failure) {
        emit(StudentState.failure(failure: failure));
      },
      (r) {
        if (r.isEmpty) {
          emit(const StudentState.empty());
        } else {
          students.addAll(r);
          emit(StudentState.studentsFetched(students: r));
        }
      },
    );
  }

  Future<void> _checkStudent(
      StudentEvent event, Emitter<StudentState> emit) async {
    event as _$CheckStudentImpl;
    emit(const StudentState.loading());
    final data = await checkStudentsUseCase(params: event.params);
    data.fold(
      (failure) {
        emit(StudentState.failure(failure: failure));
      },
      (r) {
        emit(const StudentState.statusCheked());
      },
    );
  }

  Future<void> _fetchAbsences(
      StudentEvent event, Emitter<StudentState> emit) async {
    emit(const StudentState.absencesLoading());
    final data = await getAbsencesUseCase();
    data.fold(
      (failure) {
        emit(StudentState.absencesFailure(failure: failure));
      },
      (r) {
        if (r.isEmpty) {
          emit(const StudentState.absencesEmpty());
        } else {
          List<StudentEntity> uniqueStudents = students.toSet().toList();

          absences = uniqueStudents.where((student) {
            return r.contains(student.uid);
          }).toList();
          emit(StudentState.absencesFetched(absences: absences));
        }
      },
    );
  }
}
