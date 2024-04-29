import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/check/params/check_params.dart';
import 'package:a_school_app/features/students/domain/repositories/student_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckStudentsUseCase {
  CheckStudentsUseCase(this.repository);

  final StudentDomainRepository repository;

  Future<Either<Failure, void>> call({
    required CheckParams params,
  }) {
    return repository.checkStudents(
      params: params,
    );
  }
}
