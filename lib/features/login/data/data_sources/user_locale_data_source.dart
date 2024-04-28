import 'package:a_school_app/core/managers/manager.dart';
import 'package:a_school_app/core/managers/pref_manager/pref_keys.dart';
import 'package:a_school_app/features/login/data/models/teacher_model.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserLocaleDataSource {
  Future<void> storeUser(TeacherModel teacherModel) async {
    await Managers.prefManager.set(
      PrefKeys.user,
      teacherModel.toJson()
        ..addAll(
          {
            TeacherKeys.uid: teacherModel.uid,
          },
        ),
    );
    debugPrint('store user in cash:\n '
        '${teacherModel.toJson()..addAll(
            {
              TeacherKeys.uid: teacherModel.uid,
            },
          )}'
        '');
  }

  Future<void> storeUserByMap(
    Map<String, dynamic> userData,
    String uid,
  ) async {
    await Managers.prefManager.set(
      PrefKeys.user,
      userData
        ..addAll(
          {
            TeacherKeys.uid: uid,
          },
        ),
    );
  }

  TeacherModel? getUser() {
    final json = Managers.prefManager.get<Map>(PrefKeys.user);
    if (json == null || json.isEmpty) return null;
    return TeacherModel.fromJson(json.cast());
  }

  Future<void> deleteUser() async {
    await Managers.prefManager.remove(PrefKeys.user);
  }
}
