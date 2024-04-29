import 'package:a_school_app/core/error/exeption.dart';
import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:a_school_app/features/login/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthDomainRepository)
class AuthRepositoryImpl implements AuthDomainRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TeacherEntity>> login(
      String email, String password) async {
    try {
      final result = await remoteDataSource.login(email, password);
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, TeacherEntity?>> loadUser() async {
    try {
      final result = await remoteDataSource.loadUser();
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final result = await remoteDataSource.signOut();
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure());
    }
  }
}
