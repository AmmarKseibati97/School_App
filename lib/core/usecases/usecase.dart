import 'package:a_school_app/core/error/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<LocalFailure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
