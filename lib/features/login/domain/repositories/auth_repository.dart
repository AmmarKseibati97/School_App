import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthDomainRepository {
  Future<Either<Failure, TeacherEntity>> login(String email, String password);
}
