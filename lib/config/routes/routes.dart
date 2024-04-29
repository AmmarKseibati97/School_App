import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/features/absence/presentation/view/absence_view.dart';
import 'package:a_school_app/features/check/presentation/cubit/check_cubit.dart';
import 'package:a_school_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:a_school_app/features/home/presentation/views/home_view.dart';
import 'package:a_school_app/features/login/presentation/views/login_view.dart';
import 'package:a_school_app/features/root/presentation/cubit/root_cubit.dart';
import 'package:a_school_app/features/students/presentation/bloc/student_bloc.dart';
import 'package:a_school_app/features/students/presentation/cubit/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/strings.dart';
import '../../features/root/presentation/views/root_view.dart';
import '../../features/splash_screen/presentation/views/splash_view.dart';

class Routes {
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String root = '/root';
  static const String students = '/students';
  static const String check = '/check';
  static const String absences = '/absences';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case Routes.home:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<HomeCubit>(),
                  child: const HomeView(),
                ));

      case Routes.absences:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<HomeCubit>(),
                  child: AbsenceView(),
                ));

      case Routes.root:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<RootCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<StudentBloc>()
                        ..add(const StudentEvent.fetchStudents()),
                    ),
                    BlocProvider(
                      create: (context) => getIt<HomeCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<CheckCubit>(),
                    ),
                  ],
                  child: const RootView(),
                ));
      default:
        return null;
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(Strings.noRoutes),
              ),
            )));
  }
}
