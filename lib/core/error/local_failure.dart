import 'package:equatable/equatable.dart';

abstract class LocalFailure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends LocalFailure {}

class CacheFailure extends LocalFailure {}
