// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a_school_app/core/api/app_interceptor.dart' as _i10;
import 'package:a_school_app/core/managers/pref_manager/pref_manager.dart'
    as _i23;
import 'package:a_school_app/core/managers/pref_manager/register_pref_manager_module.dart'
    as _i34;
import 'package:a_school_app/core/network/network_info.dart' as _i14;
import 'package:a_school_app/core/realtime/realtime_database.dart' as _i13;
import 'package:a_school_app/core/service_locator/injection_module.dart'
    as _i35;
import 'package:a_school_app/features/check/presentation/cubit/check_cubit.dart'
    as _i7;
import 'package:a_school_app/features/home/presentation/cubit/home_cubit.dart'
    as _i4;
import 'package:a_school_app/features/login/data/data_sources/auth_remote_data_source.dart'
    as _i12;
import 'package:a_school_app/features/login/data/data_sources/user_locale_data_source.dart'
    as _i8;
import 'package:a_school_app/features/login/data/repositories/auth_repository_impl.dart'
    as _i28;
import 'package:a_school_app/features/login/domain/repositories/auth_repository.dart'
    as _i27;
import 'package:a_school_app/features/login/domain/use_cases/load_user_usecase.dart'
    as _i30;
import 'package:a_school_app/features/login/domain/use_cases/login_usecase%20copy%202.dart'
    as _i32;
import 'package:a_school_app/features/login/domain/use_cases/login_usecase.dart'
    as _i31;
import 'package:a_school_app/features/login/presentation/bloc/auth_bloc.dart'
    as _i33;
import 'package:a_school_app/features/root/presentation/cubit/root_cubit.dart'
    as _i6;
import 'package:a_school_app/features/splash_screen/data/endpoint/lang_local_data_source.dart'
    as _i15;
import 'package:a_school_app/features/splash_screen/data/repository/lang_repository_impl.dart'
    as _i22;
import 'package:a_school_app/features/splash_screen/domain/repository/lang_repository.dart'
    as _i21;
import 'package:a_school_app/features/splash_screen/domain/usecases/change_locale.dart'
    as _i25;
import 'package:a_school_app/features/splash_screen/domain/usecases/get_saved_lang.dart'
    as _i26;
import 'package:a_school_app/features/splash_screen/presentation/cubit/local_cubit.dart'
    as _i29;
import 'package:a_school_app/features/students/data/data_sources/student_remote_data_source.dart'
    as _i11;
import 'package:a_school_app/features/students/data/repositories/student_repository_impl.dart'
    as _i17;
import 'package:a_school_app/features/students/domain/repositories/student_repository.dart'
    as _i16;
import 'package:a_school_app/features/students/domain/use_cases/check_students_usecase.dart'
    as _i18;
import 'package:a_school_app/features/students/domain/use_cases/fetch_students_usecase.dart'
    as _i19;
import 'package:a_school_app/features/students/domain/use_cases/get_absense_usecase.dart'
    as _i20;
import 'package:a_school_app/features/students/presentation/bloc/student_bloc.dart'
    as _i24;
import 'package:a_school_app/features/students/presentation/cubit/students_cubit.dart'
    as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i9;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerPrefManagerModule = _$RegisterPrefManagerModule();
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => registerPrefManagerModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i4.HomeCubit>(() => _i4.HomeCubit());
    gh.factory<_i5.StudentsCubit>(() => _i5.StudentsCubit());
    gh.factory<_i6.RootCubit>(() => _i6.RootCubit());
    gh.factory<_i7.CheckCubit>(() => _i7.CheckCubit());
    gh.singleton<_i8.UserLocaleDataSource>(() => _i8.UserLocaleDataSource());
    gh.lazySingleton<_i9.InternetConnectionChecker>(
        () => registerModule.connectionChecker);
    gh.lazySingleton<_i10.AppInterceptors>(() => _i10.AppInterceptors());
    gh.lazySingleton<_i11.StudentRemoteDataSource>(
        () => _i11.StudentRemoteDataSourceImpl());
    gh.lazySingleton<_i12.AuthRemoteDataSource>(
        () => _i12.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i13.RealTimeDataBase>(() => _i13.RealTimeDataBaseImpl());
    gh.lazySingleton<_i14.NetworkInfo>(() => _i14.NetworkInfoImpl(
        connectionChecker: gh<_i9.InternetConnectionChecker>()));
    gh.lazySingleton<_i15.LangLocalDataSource>(() =>
        _i15.LangLocalDataSourceImpl(
            sharedPreferences: gh<_i3.SharedPreferences>()));
    gh.singleton<_i16.StudentDomainRepository>(
        () => _i17.StudentRepositoryImpl(gh<_i11.StudentRemoteDataSource>()));
    gh.lazySingleton<_i18.CheckStudentsUseCase>(
        () => _i18.CheckStudentsUseCase(gh<_i16.StudentDomainRepository>()));
    gh.lazySingleton<_i19.FetchStudentsUseCase>(
        () => _i19.FetchStudentsUseCase(gh<_i16.StudentDomainRepository>()));
    gh.lazySingleton<_i20.GetAbsencesUseCase>(
        () => _i20.GetAbsencesUseCase(gh<_i16.StudentDomainRepository>()));
    gh.lazySingleton<_i21.LangRepository>(() => _i22.LangRepositoryImpl(
        langLocalDataSource: gh<_i15.LangLocalDataSource>()));
    gh.lazySingleton<_i23.PrefManagerImpl>(
        () => _i23.PrefManagerImpl(gh<_i3.SharedPreferences>()));
    gh.singleton<_i24.StudentBloc>(() => _i24.StudentBloc(
          fetchStudentsUseCase: gh<_i19.FetchStudentsUseCase>(),
          checkStudentsUseCase: gh<_i18.CheckStudentsUseCase>(),
          getAbsencesUseCase: gh<_i20.GetAbsencesUseCase>(),
        ));
    gh.lazySingleton<_i25.ChangeLangUseCase>(() =>
        _i25.ChangeLangUseCase(langRepository: gh<_i21.LangRepository>()));
    gh.lazySingleton<_i26.GetSavedLangUseCase>(() =>
        _i26.GetSavedLangUseCase(langRepository: gh<_i21.LangRepository>()));
    gh.singleton<_i27.AuthDomainRepository>(
        () => _i28.AuthRepositoryImpl(gh<_i12.AuthRemoteDataSource>()));
    gh.lazySingleton<_i29.LocaleCubit>(() => _i29.LocaleCubit(
          getSavedLangUseCase: gh<_i26.GetSavedLangUseCase>(),
          changeLangUseCase: gh<_i25.ChangeLangUseCase>(),
        ));
    gh.lazySingleton<_i30.LoadUserUseCase>(
        () => _i30.LoadUserUseCase(gh<_i27.AuthDomainRepository>()));
    gh.lazySingleton<_i31.LoginUseCase>(
        () => _i31.LoginUseCase(gh<_i27.AuthDomainRepository>()));
    gh.lazySingleton<_i32.SignOutUseCase>(
        () => _i32.SignOutUseCase(gh<_i27.AuthDomainRepository>()));
    gh.factory<_i33.AuthBloc>(() => _i33.AuthBloc(
          loginUseCase: gh<_i31.LoginUseCase>(),
          loadUserUseCase: gh<_i30.LoadUserUseCase>(),
          signOutUseCase: gh<_i32.SignOutUseCase>(),
        ));
    return this;
  }
}

class _$RegisterPrefManagerModule extends _i34.RegisterPrefManagerModule {}

class _$RegisterModule extends _i35.RegisterModule {}
