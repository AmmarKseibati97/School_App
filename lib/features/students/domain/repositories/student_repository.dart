import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/check/params/check_params.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:dartz/dartz.dart';

abstract class StudentDomainRepository {
  Future<Either<Failure, List<StudentEntity>>> fetchStudents();
  Future<Either<Failure, List<StudentEntity>>> checkStudents({
    required CheckParams params,
  });
  Future<Either<Failure, List<StudentEntity>>> fetchChecks();

  Future<Either<Failure, List<String>>> getAbsences();
}
