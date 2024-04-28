import 'package:a_school_app/core/realtime/database_reference.dart';
import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/features/login/data/data_sources/user_locale_data_source.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:a_school_app/core/managers/manager.dart';
import 'package:a_school_app/features/login/data/models/teacher_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<TeacherEntity> login(String email, String password);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final UserLocaleDataSource localeDataSource = getIt();
  @override
  Future<TeacherEntity> login(String email, String password) async {
    //Login using email and password.
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (user.user == null) {
      throw Exception('The user could not be logged in.');
    }

    //Get the user row data.
    final data = await Managers.realTimeDatabase
        .get<Map>(DatabaseReference.userTeacherInfo(
      user.user!.uid,
    ));

    //Insert ID into JSON map.
    data[TeacherKeys.uid] = user.user!.uid;
    localeDataSource.storeUser(TeacherModel.fromJson(data.cast()));

    //Insert account type into JSON map.
    //Return the user model depending on account type.
    return TeacherModel.fromJson(data.cast());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    //Index the user in Fire-store.
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential;
      print("email ${user.user!.email}");

      //Create user model depending on account type.
      final userInfo =
          TeacherModel(uid: user.user!.uid, email: email, name: 'teacher');
      //Create user info node in Real-time database.
      await Managers.realTimeDatabase.set(
        ref: DatabaseReference.userTeacherInfo(
          user.user!.uid,
        ),
        data: userInfo.toJson(),
      );
    } catch (e) {
      print("error $e");
    }
  }
}
