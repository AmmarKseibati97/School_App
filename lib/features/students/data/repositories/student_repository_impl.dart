import 'package:a_school_app/core/error/exeption.dart';
import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/check/params/check_params.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:a_school_app/features/students/data/data_sources/student_remote_data_source.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:a_school_app/features/students/domain/repositories/student_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: StudentDomainRepository)
class StudentRepositoryImpl implements StudentDomainRepository {
  final StudentRemoteDataSource remoteDataSource;
  StudentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<StudentEntity>>> fetchStudents() async {
    try {
      final result = await remoteDataSource.fetchStudents();
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> checkStudents(
      {required CheckParams params}) async {
    try {
      final result = await remoteDataSource.checkStudents(params: params);
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAbsences() async {
    try {
      final result = await remoteDataSource.getAbsences();
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> fetchChecks() async {
    try {
      final result = await remoteDataSource.fetchChecks();
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }
}
