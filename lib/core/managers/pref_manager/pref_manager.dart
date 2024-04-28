import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefManager {
  T? get<T>(String key);

  Future<void> set(String key, dynamic value);

  Future<void> remove(String key);

  Future<void> clear();
}

@lazySingleton
class PrefManagerImpl extends PrefManager {
  final SharedPreferences _preferences;

  PrefManagerImpl(this._preferences);

  @override
  T? get<T>(String key) {
    final value = _preferences.getString(key);
    Logger().i('Getting from cache  key:: $key');
    final decodedValue = jsonDecode(value ?? '{}');
    if (decodedValue is T) {
      Logger().i('The value in cache with key $key is $decodedValue');
      return decodedValue;
    } else {
      return null;
    }
  }

  @override
  Future<void> set(String key, dynamic value) async {
    Logger().i('Caching in key:: $key value :: $value');
    final encodedValue = jsonEncode(value);
    await _preferences.setString(key, encodedValue);
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> clear() async {
    _preferences.clear();
  }
}
