import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/realtime/database_reference.dart';
import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/features/check/presentation/cubit/check_cubit.dart';
import 'package:a_school_app/features/login/data/data_sources/user_locale_data_source.dart';
import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:a_school_app/core/managers/manager.dart';
import 'package:a_school_app/features/login/data/models/teacher_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'dart:math';

abstract class AuthRemoteDataSource {
  Future<TeacherEntity> login(String email, String password);
  Future<TeacherEntity?> loadUser();
  Future<TeacherEntity?> signOut();
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

  @override
  Future<TeacherEntity?> loadUser() async {
    final TeacherModel? teacher = localeDataSource.getUser();

    return teacher;
  }

  @override
  Future<TeacherEntity?> signOut() async {
    localeDataSource.deleteUser();

    return null;
  }

  void addStudentsWithAutoUID() {
    List<String> studentNames = [
      "John Doe",
      "Jane Smith",
      "Alice Johnson",
      "Bob Lee",
      "Chris Green",
      "Dana White",
      "Evan Black",
      "Fiona Grey",
      "George King",
      "Helen Queen",
      "Ian Knight",
      "Jill Bishop",
      "Kevin Rook",
      "Lily Pawn",
      "Mike Castle"
    ];

    int padLength = studentNames.length.toString().length;
    final checks = [
      ChecksType.present,
      ChecksType.leave,
      ChecksType.absences,
      ChecksType.present,
      ChecksType.leave,
      ChecksType.absences,
      ChecksType.present,
      ChecksType.leave,
      ChecksType.absences,
      ChecksType.present,
      ChecksType.leave,
      ChecksType.absences,
      ChecksType.present,
      ChecksType.leave,
    ];
    Random random = Random();

    for (int i = 0; i < studentNames.length; i++) {
      String studentID = "S" + i.toString().padLeft(padLength, '0');
      List<String> dates = List.generate(5, (index) {
        int randomDay = random.nextInt(30) + 1; // April has 30 days
        return "2024-04-${randomDay.toString().padLeft(2, '0')}";
      });
      Managers.realTimeDatabase.set(ref: 'students/$studentID', data: {
        "name": studentNames[i],
        "check_status": checks[i].name,
        "checked_in_at":
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        "checked_out_at":
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        "leave_at":
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'absence_dates': dates,
      });
    }
  }

  void pushAbsencesForApril2024() {
    List<String> studentUids = [
      "S00",
      "S01",
      "S02",
      "S03",
      "S04",
      "S05",
      "S06",
      "S07",
      "S08",
      "S09",
      "S10",
      "S11",
      "S12",
      "S13",
      "S14"
    ];

    Random random = Random();

    // Generate a list of 5 random dates in April 2024
    List<String> dates = List.generate(5, (index) {
      int randomDay = random.nextInt(30) + 1; // April has 30 days
      return "2024-04-${randomDay.toString().padLeft(2, '0')}";
    });

    // For each date, select 5 random student UIDs
    for (String date in dates) {
      Set<String> absentStudents = {};
      while (absentStudents.length < 5) {
        int randomIndex = random.nextInt(studentUids.length);
        absentStudents.add(studentUids[randomIndex]);
      }

      // Update the database for the selected date with the absent student UIDs
      Managers.realTimeDatabase.set(
        ref: 'absences/$date',
        data: absentStudents.toList(),
      );
    }
  }
}
