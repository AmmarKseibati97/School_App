import 'dart:async';
import 'package:a_school_app/core/managers/manager.dart';
import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/features/splash_screen/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;

  void navigateToMainPage() {
    print(" Managers.authCubit.teacher  ${Managers.authCubit.teacher}");
    Navigator.pushReplacementNamed(
      context,
      Managers.authCubit.teacher == null ? Routes.login : Routes.home,
    );
  }

  _startDelay() {
    getIt<AuthCubit>().loadUser();
    _timer = Timer(
        const Duration(
          milliseconds: 200,
        ),
        () => navigateToMainPage());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Image.asset(Images.aSchoolImage),
      ),
    );
  }
}
