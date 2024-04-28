import 'dart:async';

import 'package:a_school_app/app.dart';
import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/service_locator/injection.config.dart';
import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  ASchoolApp.flavor = Flavor.development;
  WidgetsFlutterBinding.ensureInitialized();
  // await di.init();
  await getIt.init();
  Bloc.observer = MyBlocObserver();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {}
  runApp(ASchoolApp.instance);
}
