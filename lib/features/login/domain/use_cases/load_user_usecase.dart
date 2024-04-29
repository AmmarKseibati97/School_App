import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:a_school_app/features/login/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoadUserUseCase {
  LoadUserUseCase(this.repository);

  final AuthDomainRepository repository;

  Future<Either<Failure, TeacherEntity?>> call() {
    return repository.loadUser();
  }
}
