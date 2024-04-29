import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:a_school_app/features/login/domain/use_cases/load_user_usecase.dart';
import 'package:a_school_app/features/login/domain/use_cases/login_usecase%20copy%202.dart';
import 'package:a_school_app/features/login/domain/use_cases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'auth_state.dart';
part 'auth_event.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUseCase,
    required this.loadUserUseCase,
    required this.signOutUseCase,
  }) : super(const AuthState.initial()) {
    on<AuthEvent>(
      (event, emit) async {
        await event.mapOrNull(
          login: (event) async => await _login(event, emit),
          loadUser: (event) async => await _loadUser(event, emit),
          signOut: (event) async => await _signOut(event, emit),
        );
      },
    );
  }
  late TeacherEntity? teacher;
  final LoginUseCase loginUseCase;
  final LoadUserUseCase loadUserUseCase;
  final SignOutUseCase signOutUseCase;

  Future<void> _login(AuthEvent event, Emitter<AuthState> emit) async {
    event as _$LoginImpl;
    emit(const AuthState.loading());
    final data =
        await loginUseCase(email: event.email, password: event.password);
    await data.fold(
      (failure) async {
        emit(AuthState.failure(failure: failure));
      },
      (r) async {
        teacher = r;
        emit(AuthState.loggedIn(teacher: teacher));
      },
    );
  }

  Future<void> _loadUser(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final data = await loadUserUseCase.call();
    await data.fold(
      (failure) async {
        emit(AuthState.failure(failure: failure));
      },
      (r) async {
        teacher = r;

        emit(AuthState.userLoaded(teacher: teacher));
      },
    );
  }

  Future<void> _signOut(AuthEvent event, Emitter<AuthState> emit) async {
    final data = await signOutUseCase.call();
    await data.fold(
      (failure) async {
        emit(AuthState.failure(failure: failure));
      },
      (r) async {
        teacher = null;
        emit(AuthState.userLoaded(teacher: teacher));
      },
    );
  }
}
