import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/error/exeption.dart';
import 'package:a_school_app/core/models/base_model.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Mapper {
  ///Map from one database snapshot to [T].
  ///If [containsId] is set to true, the [idFieldName] will be used as the first
  ///entry key.
  ///and snapshot must be like this:
  /// {
  ///   "[idFieldName]": {
  ///           key:value,
  ///           key2:value2,
  ///               ...
  ///               ...
  ///         },
  /// }
  ///If [containsId] is set to false , the [idFieldName] will be ignored.
  ///And snapshot must be like this:
  /// {
  ///     key : value,
  ///     key2 :value2,
  ///         ...
  ///         ...
  ///  }
  ///
  static T mapFromFirebaseSnapshot<T extends Model>({
    required Object snapshot,
    bool containsId = false,
    String idFieldName = '',
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    try {
      ///Make sure that every thing passed is correct.
      _validateIdField(containsId: containsId, idFieldName: idFieldName);

      ///Make sure that snapshot can be mapped.
      final data = _validateSnapshot(snapshot);

      ///Start mapping.
      Logger().d('Mapping $data to $T');
      if (containsId) {
        final Map<String, Map<String, dynamic>> jsonWithId = data.cast();
        final Map<String, dynamic> json = jsonWithId.values.first;
        json.addAll({
          idFieldName: json,
        });
        Logger().d('Mapping completed with $json');
        return fromJson(json);
      } else {
        Logger().d('Mapping completed with $data');
        return fromJson(data);
      }
    } catch (e) {
      throw AppException(
        code: ExceptionCode.mappingError,
        message: e.toString(),
      );
    }
  }

  ///Map from firebase snapshot to List<T> that extends [Model]
  ///if [containsId] is true, [idFieldName] is used to get the id from the json
  /// so the snapshot is like this:
  /// {
  ///   "id":{key:value},
  ///   "id2":{key:value},
  ///         ...
  ///         ...
  /// }
  ///  if [containsId] is false, [idFieldName] is ignored.
  ///  so the snapshot is like this:
  ///  {
  ///     key : value,
  ///     key2 : value2,
  ///         ...
  ///         ...
  ///  }
  ///
  static List<T> mapToListFromFirebaseSnapshot<T extends Model>({
    required Object? snapshot,
    required T Function(Map<String, dynamic> json) fromJson,
    bool containsId = false,
    String idFieldName = '',
  }) {
    try {
      ///Validate that every thing passed is correct.
      _validateIdField(containsId: containsId, idFieldName: idFieldName);

      ///Validate that snapshot can be mapped.

      final data = _validateListSnapshot(snapshot);

      ///Start mapping.
      Logger().d('Mapping $data to ${T.runtimeType}');

      final List<T> result = <T>[];

      if (containsId) {
        final Map<String, Map> jsonListWithId = data.cast();
        for (final entry in jsonListWithId.entries) {
          final Map<String, dynamic> value = Map.from(entry.value);
          final json = value
            ..addAll({
              idFieldName: entry.key,
            });
          try {
            result.add(fromJson(json));
          } catch (e) {
            continue;
          }
        }
      } else {
        for (final entry in data.entries) {
          if (entry.value is Map<String, dynamic>) {
            try {
              final Map<String, dynamic> value =
                  Map<String, dynamic>.from(entry.value);
              result.add(fromJson(value));
            } catch (e) {}
          }
        }
      }
      return result;
    } catch (e) {
      throw AppException(
        code: ExceptionCode.mappingError,
        message: e.toString(),
      );
    }
  }

  static void _validateIdField({
    required bool containsId,
    required String idFieldName,
  }) {
    assert(
      (containsId && idFieldName != '') || (!containsId && idFieldName == ''),
    );
  }

  static Map<String, dynamic> _validateSnapshot(Object snapshot) {
    if (snapshot is! Map) {
      Logger().t('if (snapshot is! Map)');
      throw AppException(
        code: ExceptionCode.mappingError,
        message: kDebugMode ? 'Error in mapping $snapshot to  Map' : null,
      );
    } else {
      Logger().t('Else');
      return snapshot.cast();
    }
  }

  static Map<String, dynamic> _validateListSnapshot(Object? snapshot) {
    if (snapshot == null) {
      return {};
    }
    if (snapshot is! Map) {
      Logger().t('if (snapshot is! Map)');
      throw AppException(
        code: ExceptionCode.mappingError,
        message: kDebugMode ? 'Error in mapping $snapshot to  Map' : null,
      );
    } else {
      Logger().t('Else');
      return snapshot.cast();
    }
  }
}
