import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/core/utils/media_query_values.dart';
import 'package:a_school_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/local/app_localizations.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/strings.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AuthRemoteDataSourceImpl()
    //     .createUserWithEmailAndPassword("ammar@gmail.com", "ammarlm4");

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset(
              Images.loginImage,
              height: 550.h,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 440.h,
                width: context.width,
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    )),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.translate('welcome_to') ?? Strings.translationError} ${Strings.appName}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color:
                                    AppColors.primary, // Change text color here
                              ),
                        ),
                        SizedBox(height: 30.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                hint: AppLocalizations.of(context)!
                                        .translate('email') ??
                                    Strings.translationError,
                                controller: emailController,
                                validator: (String? value) => validateInput(
                                  value,
                                  context,
                                  ValidationType.email,
                                ),
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextField(
                                hint: AppLocalizations.of(context)!
                                        .translate('password') ??
                                    Strings.translationError,
                                controller: passwordController,
                                validator: (String? value) => validateInput(
                                  value,
                                  context,
                                  ValidationType.password,
                                ),
                                isPassword: true,
                                keyboardType: TextInputType.visiblePassword,
                                maxLines: 1,
                              ),
                              SizedBox(height: 22.h),
                              GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                            .translate('forget_pass') ??
                                        Strings.translationError,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: AppColors.primary,
                                            fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              BlocListener<AuthBloc, AuthState>(
                                listenWhen: (previous, current) {
                                  if (current.runtimeType ==
                                      const AuthState.loggedIn().runtimeType) {
                                    return true;
                                  }
                                  return false;
                                },
                                listener: (context, state) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, Routes.home, (p) {
                                    return false;
                                  });
                                },
                                child: PrimaryButton(
                                    title: AppLocalizations.of(context)!
                                            .translate('sign_in') ??
                                        Strings.translationError,
                                    onPressed: () {
                                      final valid =
                                          _formKey.currentState?.validate() ??
                                              false;
                                      if (valid) {
                                        context.read<AuthBloc>().add(
                                            AuthEvent.login(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text));
                                      }
                                    },
                                    backgroundColor: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
