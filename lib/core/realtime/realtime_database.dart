import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/error/exeption.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class RealTimeDataBase {
  ///Get the data from specific node in
  ///Real-Time DataBase.
  Future<T> get<T>(
    String ref, {
    String? orderByChild,
    Object? equalTo,
  });

  ///Set the data in specific node in
  ///Real-Time DataBase.
  Future<void> set({
    required String ref,
    required dynamic data,
  });

  ///Push unique auto-generated id before pushing
  ///the data in the reference.

  Future<DatabaseReference> push({
    required String ref,
    required dynamic data,
  });

  Future<void> update({
    required String ref,
    required Map<String, dynamic> data,
  });
  Future<T> performSearch<T>({
    required String ref,
    required String keyword,
    required String orderByChild,
  });
}

@LazySingleton(as: RealTimeDataBase)
class RealTimeDataBaseImpl implements RealTimeDataBase {
  final firebase = FirebaseDatabase.instance;

  @override
  Future<T> get<T>(
    String ref, {
    String? orderByChild,
    Object? equalTo,
  }) async {
    final DataSnapshot snapshot;
    if (orderByChild != null) {
      Logger().i(
        'Getting data from Firebase with query order by child ${orderByChild} ref $ref',
      );
      snapshot = (await firebase
              .ref(ref)
              .orderByChild(orderByChild)
              .equalTo(equalTo)
              .once())
          .snapshot;
    } else {
      Logger().i('Getting data from Firebase with ref $ref');
      snapshot = await firebase.ref(ref).get();
    }

    Logger().i('The value with ref is ${snapshot.value}');
    final value = snapshot.value;
    if (value is T) {
      return value;
    } else {
      throw const AppException(code: ExceptionCode.invalidData);
    }
  }

  @override
  Future<void> set({
    required String ref,
    required dynamic data,
  }) async {
    Logger().i('Setting \n $data \n in Firebase with ref $ref');
    await firebase.ref(ref).set(data);
    Logger().i('✅✅✅✅ set \n $data \n in $ref Firebase completed successfully');
  }

  @override
  Future<DatabaseReference> push({
    required String ref,
    required dynamic data,
  }) async {
    Logger().i('Pushing \n $data \n in Firebase with ref $ref');
    DatabaseReference reference = firebase.ref(ref).push();
    await reference.set(data);
    Logger().i('✅✅✅✅ Push \n $data \n in $ref Firebase completed successfully');
    return reference;
  }

  @override
  Future<T> performSearch<T>({
    required String ref,
    required String keyword,
    required String orderByChild,
  }) async {
    Logger().i(
      'Searching in Firebase at $ref for items starting with "$keyword"',
    );

    Query query = firebase
        .ref(ref)
        .orderByChild(orderByChild)
        .startAt(keyword)
        .endAt('$keyword\uf8ff');

    DataSnapshot snapshot = await query.get();

    if (snapshot.exists) {
      Logger().i('Search results found.');
      final data = snapshot.value;
      if (data is T) {
        return data;
      } else {
        throw AppException(
            code: ExceptionCode.invalidData,
            message: 'Expected data type $T but received ${data.runtimeType}');
      }
    } else {
      Logger().i('No results found for the search.');
      // Assuming that returning an empty Map is acceptable if T is expected to be Map<String, dynamic>
      if (T == Map) {
        return <String, dynamic>{} as T;
      } else {
        throw const AppException(
            code: ExceptionCode.invalidData,
            message: 'No data found and expected type is not Map.');
      }
    }
  }

  @override
  Future<void> update({
    required String ref,
    required Map<String, dynamic> data,
  }) async {
    Logger().i('Updating \n $data \n in Firebase with ref $ref');
    await firebase.ref(ref).update(data);
    Logger()
        .i('✅✅✅✅ Updating \n $data \n in $ref Firebase completed successfully');
  }
}
