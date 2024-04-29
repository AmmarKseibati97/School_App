import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:a_school_app/features/students/domain/repositories/student_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchStudentsUseCase {
  FetchStudentsUseCase(this.repository);

  final StudentDomainRepository repository;

  Future<Either<Failure, List<StudentEntity>>> call() {
    return repository.fetchStudents();
  }
}
