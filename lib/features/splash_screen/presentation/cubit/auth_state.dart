part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final TeacherEntity? teacher;
  const AuthState(this.teacher);

  @override
  List<Object?> get props => [teacher];
}

class InitialState extends AuthState {
  const InitialState(super.teacher);
}
