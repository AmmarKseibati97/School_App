import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:a_school_app/features/login/data/data_sources/user_locale_data_source.dart';

import 'package:injectable/injectable.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  TeacherEntity? teacher;
  final UserLocaleDataSource localDataSource = getIt();
  AuthCubit() : super(const InitialState(null));

  void loadUser() {
    teacher = localDataSource.getUser();
    emit(InitialState(teacher));
    print("loadUser $teacher");
  }

  Future<void> signOut() async {
    await localDataSource.deleteUser();
    teacher = null;
  }
}
