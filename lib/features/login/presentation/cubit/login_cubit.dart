import 'package:a_school_app/core/managers/manager.dart';
import 'package:a_school_app/core/realtime/database_reference.dart';
import 'package:a_school_app/features/login/data/models/teacher_model.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordVisible = true;
}
