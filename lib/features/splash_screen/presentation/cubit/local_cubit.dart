import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/features/login/data/data_sources/user_locale_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/usecases/change_locale.dart';
import '../../domain/usecases/get_saved_lang.dart';

part 'local_state.dart';

@lazySingleton
class LocaleCubit extends Cubit<LocalState> {
  LocaleCubit(
      {required this.getSavedLangUseCase, required this.changeLangUseCase})
      : super(const ChangeLocalState(Locale(Strings.englishCode)));

  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;
  final localDataSource = getIt<UserLocaleDataSource>();

  String currentLangCode = Strings.englishCode;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint(Strings.cacheFailure), (value) {
      currentLangCode = value;
      emit(ChangeLocalState(Locale(currentLangCode)));
    });
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold((failure) => debugPrint(Strings.cacheFailure), (value) {
      currentLangCode = langCode;
      emit(ChangeLocalState(Locale(currentLangCode)));
    });
  }

  void toEnglish() => _changeLang(Strings.englishCode);

  void toArabic() => _changeLang(Strings.arabicCode);
}
