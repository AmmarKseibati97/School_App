// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:a_school_app/core/api/app_interceptor.dart' as _i10;
import 'package:a_school_app/core/managers/pref_manager/pref_manager.dart'
    as _i19;
import 'package:a_school_app/core/managers/pref_manager/register_pref_manager_module.dart'
    as _i26;
import 'package:a_school_app/core/network/network_info.dart' as _i15;
import 'package:a_school_app/core/realtime/realtime_database.dart' as _i14;
import 'package:a_school_app/core/service_locator/injection_module.dart'
    as _i27;
import 'package:a_school_app/features/check/presentation/cubit/check_cubit.dart'
    as _i7;
import 'package:a_school_app/features/home/presentation/cubit/home_cubit.dart'
    as _i4;
import 'package:a_school_app/features/login/data/data_sources/auth_remote_data_source.dart'
    as _i13;
import 'package:a_school_app/features/login/data/data_sources/user_locale_data_source.dart'
    as _i9;
import 'package:a_school_app/features/login/data/repositories/auth_repository_impl.dart'
    as _i23;
import 'package:a_school_app/features/login/domain/repositories/auth_repository.dart'
    as _i22;
import 'package:a_school_app/features/login/domain/use_cases/login_usecase.dart'
    as _i25;
import 'package:a_school_app/features/login/presentation/cubit/login_cubit.dart'
    as _i8;
import 'package:a_school_app/features/root/presentation/cubit/root_cubit.dart'
    as _i6;
import 'package:a_school_app/features/splash_screen/data/endpoint/lang_local_data_source.dart'
    as _i16;
import 'package:a_school_app/features/splash_screen/data/repository/lang_repository_impl.dart'
    as _i18;
import 'package:a_school_app/features/splash_screen/domain/repository/lang_repository.dart'
    as _i17;
import 'package:a_school_app/features/splash_screen/domain/usecases/change_locale.dart'
    as _i20;
import 'package:a_school_app/features/splash_screen/domain/usecases/get_saved_lang.dart'
    as _i21;
import 'package:a_school_app/features/splash_screen/presentation/cubit/auth_cubit.dart'
    as _i11;
import 'package:a_school_app/features/splash_screen/presentation/cubit/local_cubit.dart'
    as _i24;
import 'package:a_school_app/features/students/presentation/cubit/students_cubit.dart'
    as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i12;
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
    gh.factory<_i8.LoginCubit>(() => _i8.LoginCubit());
    gh.singleton<_i9.UserLocaleDataSource>(() => _i9.UserLocaleDataSource());
    gh.lazySingleton<_i10.AppInterceptors>(() => _i10.AppInterceptors());
    gh.lazySingleton<_i11.AuthCubit>(() => _i11.AuthCubit());
    gh.lazySingleton<_i12.InternetConnectionChecker>(
        () => registerModule.connectionChecker);
    gh.lazySingleton<_i13.AuthRemoteDataSource>(
        () => _i13.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i14.RealTimeDataBase>(() => _i14.RealTimeDataBaseImpl());
    gh.lazySingleton<_i15.NetworkInfo>(() => _i15.NetworkInfoImpl(
        connectionChecker: gh<_i12.InternetConnectionChecker>()));
    gh.lazySingleton<_i16.LangLocalDataSource>(() =>
        _i16.LangLocalDataSourceImpl(
            sharedPreferences: gh<_i3.SharedPreferences>()));
    gh.lazySingleton<_i17.LangRepository>(() => _i18.LangRepositoryImpl(
        langLocalDataSource: gh<_i16.LangLocalDataSource>()));
    gh.lazySingleton<_i19.PrefManagerImpl>(
        () => _i19.PrefManagerImpl(gh<_i3.SharedPreferences>()));
    gh.lazySingleton<_i20.ChangeLangUseCase>(() =>
        _i20.ChangeLangUseCase(langRepository: gh<_i17.LangRepository>()));
    gh.lazySingleton<_i21.GetSavedLangUseCase>(() =>
        _i21.GetSavedLangUseCase(langRepository: gh<_i17.LangRepository>()));
    gh.singleton<_i22.AuthDomainRepository>(
        () => _i23.AuthRepositoryImpl(gh<_i13.AuthRemoteDataSource>()));
    gh.lazySingleton<_i24.LocaleCubit>(() => _i24.LocaleCubit(
          getSavedLangUseCase: gh<_i21.GetSavedLangUseCase>(),
          changeLangUseCase: gh<_i20.ChangeLangUseCase>(),
        ));
    gh.lazySingleton<_i25.LoginUseCase>(
        () => _i25.LoginUseCase(gh<_i22.AuthDomainRepository>()));
    return this;
  }
}

class _$RegisterPrefManagerModule extends _i26.RegisterPrefManagerModule {}

class _$RegisterModule extends _i27.RegisterModule {}
