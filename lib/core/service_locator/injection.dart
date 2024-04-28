import 'package:a_school_app/core/service_locator/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
)
Future<void> configureDependencies() async {
  await getIt.init();
}
