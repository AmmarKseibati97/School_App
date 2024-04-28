import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/core/utils/media_query_values.dart';
import 'package:a_school_app/features/login/data/data_sources/auth_remote_data_source.dart';
import 'package:a_school_app/features/login/presentation/cubit/login_cubit.dart';
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
  late LoginCubit loginCubit = BlocProvider.of(context);

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
                height: 400.h,
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
                          key: loginCubit.loginFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                hint: AppLocalizations.of(context)!
                                        .translate('email') ??
                                    Strings.translationError,
                                controller: loginCubit.emailController,
                                validator: (value) {
                                  // if (value == null || value.isEmpty) {
                                  //   return ErrorStrings.enterEmail;
                                  // } else if (!GeneralServices
                                  //     .isEmailValid(value)) {
                                  //   return ErrorStrings.enterValidEmail;
                                  // }
                                  return null; // Return null to indicate no validation error
                                },
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextField(
                                hint: AppLocalizations.of(context)!
                                        .translate('password') ??
                                    Strings.translationError,
                                controller: loginCubit.passwordController,
                                obscureText: loginCubit.passwordVisible,
                                // validator: (value) => value!.isEmpty
                                //     ? ErrorStrings.enterPassword
                                //     : null,
                                keyboardType: TextInputType.visiblePassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.visibility,
                                    color: AppColors.primary,
                                    size: 20.sp,
                                  ),
                                  onPressed: () {},
                                ),
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
                              PrimaryButton(
                                  title: AppLocalizations.of(context)!
                                          .translate('sign_in') ??
                                      Strings.translationError,
                                  onPressed: () {
                                    AuthRemoteDataSourceImpl()
                                        .login("ammar@gmail.com", "ammarlm4");
                                    Navigator.pushReplacementNamed(
                                        context, Routes.root);
                                  },
                                  backgroundColor: AppColors.primary),
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
