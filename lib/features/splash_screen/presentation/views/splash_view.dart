import 'dart:async';
import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:a_school_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:a_school_app/features/students/data/data_sources/student_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer timer;
  late TeacherEntity? teacher;

  void navigateToMainPage(TeacherEntity? teacher) {
    timer = Timer(
        const Duration(
          milliseconds: 700,
        ),
        () => Navigator.pushReplacementNamed(
              context,
              teacher == null ? Routes.login : Routes.root,
            ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AuthRemoteDataSourceImpl().addStudentsWithAutoUID();
    // AuthRemoteDataSourceImpl().pushAbsencesForApril2024();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) {
          if (current.runtimeType == const AuthState.userLoaded().runtimeType) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => const Offstage(),
            userLoaded: (teacher) {
              navigateToMainPage(teacher);
            },
          );
        },
        child: Center(
          child: Image.asset(Images.aSchoolImage),
        ),
      ),
    );
  }
}
