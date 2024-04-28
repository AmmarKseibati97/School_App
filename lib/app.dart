import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/features/splash_screen/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/local/app_localizations_setup.dart';
import 'config/routes/routes.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/strings.dart';
import 'features/splash_screen/presentation/cubit/local_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ASchoolApp extends StatefulWidget {
  const ASchoolApp({super.key});
  const ASchoolApp._internal();

  static const ASchoolApp instance = ASchoolApp._internal();
  static Flavor flavor = Flavor.development;

  @override
  State<ASchoolApp> createState() => _ASchoolAppState();
}

class _ASchoolAppState extends State<ASchoolApp> {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => getIt<LocaleCubit>()..getSavedLang()),
                BlocProvider(create: (context) => getIt<AuthCubit>()),
              ],
              child: BlocBuilder<LocaleCubit, LocalState>(
                  buildWhen: (previousState, currentState) =>
                      previousState != currentState,
                  builder: (context, state) => MaterialApp(
                        title: Strings.appName,
                        debugShowCheckedModeBanner: false,
                        locale: state.locale,
                        theme: appTheme(),
                        onGenerateRoute: AppRoutes.onGenerateRoute,
                        supportedLocales:
                            AppLocalizationsSetup.supportedLocales,
                        localeResolutionCallback:
                            AppLocalizationsSetup.localeResolutionCallback,
                        localizationsDelegates:
                            AppLocalizationsSetup.localizationsDelegates,
                      ))));
}
