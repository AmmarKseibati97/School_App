import 'package:a_school_app/core/managers/pref_manager/pref_manager.dart';
import 'package:a_school_app/core/realtime/realtime_database.dart';
import 'package:a_school_app/core/service_locator/injection.dart';

class Managers {
  Managers._();
  static PrefManager prefManager = getIt<PrefManagerImpl>();
  static RealTimeDataBase realTimeDatabase = getIt<RealTimeDataBase>();
}
