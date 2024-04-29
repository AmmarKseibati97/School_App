import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/login/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOutUseCase {
  SignOutUseCase(this.repository);

  final AuthDomainRepository repository;

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
