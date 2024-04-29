part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.failure({
    @Default(null) Failure? failure,
  }) = _Failure;
  const factory AuthState.empty() = _Empty;
  const factory AuthState.loggedIn({
    @Default(null) TeacherEntity? teacher,
  }) = _LoggedIn;

  const factory AuthState.userLoaded({
    @Default(null) TeacherEntity? teacher,
  }) = _UserLoaded;
}
