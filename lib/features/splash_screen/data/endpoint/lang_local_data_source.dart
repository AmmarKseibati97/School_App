import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/strings.dart';

abstract class LangLocalDataSource {
  Future<bool> changeLang({required String langCode});

  Future<String?> getSavedLang();
}

@LazySingleton(as: LangLocalDataSource)
class LangLocalDataSourceImpl implements LangLocalDataSource {
  final SharedPreferences sharedPreferences;

  LangLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> changeLang({required String langCode}) async =>
      await sharedPreferences.setString(Strings.locale, langCode);

  @override
  Future<String?> getSavedLang() async =>
      sharedPreferences.containsKey(Strings.locale)
          ? sharedPreferences.getString(Strings.locale)
          : Strings.englishCode;
}
