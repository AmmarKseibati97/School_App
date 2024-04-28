import 'package:a_school_app/core/managers/pref_manager/pref_manager.dart';
import 'package:a_school_app/core/realtime/realtime_database.dart';
import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/features/splash_screen/presentation/cubit/auth_cubit.dart';

class Managers {
  static PrefManager prefManager = getIt<PrefManagerImpl>();
  static RealTimeDataBase realTimeDatabase = getIt<RealTimeDataBase>();
  static AuthCubit authCubit = getIt<AuthCubit>();
}
