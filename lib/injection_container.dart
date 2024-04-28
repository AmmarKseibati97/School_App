// import 'package:a_school_app/core/managers/pref_manager/pref_manager.dart';
// import 'package:a_school_app/core/realtime/realtime_database.dart';
// import 'package:a_school_app/features/check/presentation/cubit/check_cubit.dart';
// import 'package:a_school_app/features/home/presentation/cubit/home_cubit.dart';
// import 'package:a_school_app/features/login/data/data_sources/auth_remote_data_source.dart';
// import 'package:a_school_app/features/login/data/data_sources/user_locale_data_source.dart';
// import 'package:a_school_app/features/login/data/repositories/auth_repository_impl.dart';
// import 'package:a_school_app/features/login/domain/repositories/auth_repository.dart';
// import 'package:a_school_app/features/login/domain/use_cases/login_usecase.dart';
// import 'package:a_school_app/features/login/presentation/cubit/login_cubit.dart';
// import 'package:a_school_app/features/root/presentation/cubit/root_cubit.dart';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'core/api/api_consumer.dart';
// import 'core/api/app_interceptor.dart';
// import 'core/api/dio_consumer.dart';
// import 'core/network/network_info.dart';
// import 'features/splash_screen/data/endpoint/lang_local_data_source.dart';
// import 'features/splash_screen/data/repository/lang_repository_impl.dart';
// import 'features/splash_screen/domain/repository/lang_repository.dart';
// import 'features/splash_screen/domain/usecases/change_locale.dart';
// import 'features/splash_screen/domain/usecases/get_saved_lang.dart';
// import 'features/splash_screen/presentation/cubit/local_cubit.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'features/students/presentation/cubit/students_cubit.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   /// Blocs
//   sl.registerFactory<LocaleCubit>(
//       () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));
//   sl.registerFactory<LoginCubit>(() => LoginCubit());
//   sl.registerFactory<RootCubit>(() => RootCubit());
//   sl.registerFactory<StudentsCubit>(() => StudentsCubit());
//   sl.registerFactory<HomeCubit>(() => HomeCubit());
//   sl.registerFactory<CheckCubit>(() => CheckCubit());
//   sl.registerFactory<RealTimeDataBase>(() => RealTimeDataBaseImpl());
//   sl.registerFactory<UserLocaleDataSource>(() => UserLocaleDataSource());

//   ///Repositories
//   sl.registerLazySingleton<LangRepository>(
//       () => LangRepositoryImpl(langLocalDataSource: sl()));
//   sl.registerLazySingleton<LangLocalDataSource>(
//       () => LangLocalDataSourceImpl(sharedPreferences: sl()));

//   sl.registerLazySingleton<AuthRemoteDataSource>(
//       () => AuthRemoteDataSourceImpl());

//   /// Use Cases
//   sl.registerLazySingleton<GetSavedLangUseCase>(
//       () => GetSavedLangUseCase(langRepository: sl()));
//   sl.registerLazySingleton<ChangeLangUseCase>(
//       () => ChangeLangUseCase(langRepository: sl()));

//   /// Core
//   sl.registerLazySingleton<NetworkInfo>(
//       () => NetworkInfoImpl(connectionChecker: sl()));
//   sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

//   /// External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton<PrefManagerImpl>(
//       () => PrefManagerImpl(sharedPreferences));
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => AppInterceptors());
//   sl.registerLazySingleton(() => LogInterceptor(
//       request: true,
//       requestBody: true,
//       requestHeader: true,
//       responseHeader: true,
//       error: true));
//   sl.registerLazySingleton(() => Dio());
//   sl.registerLazySingleton(() => InternetConnectionChecker());
// }
