import 'package:a_school_app/core/managers/manager.dart';
import 'package:a_school_app/core/mapper/mapper.dart';
import 'package:a_school_app/core/realtime/database_reference.dart';
import 'package:a_school_app/features/check/params/check_params.dart';
import 'package:a_school_app/features/students/data/models/student_model.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class StudentRemoteDataSource {
  Future<List<StudentEntity>> fetchStudents();
  Future<List<StudentEntity>> fetchChecks();

  Future<void> checkStudents({
    required CheckParams params,
  });
  Future<List<String>> getAbsences();
}

@LazySingleton(as: StudentRemoteDataSource)
class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  @override
  Future<List<StudentEntity>> fetchStudents() async {
    String ref = DatabaseReference.students;
    final snapshot = await Managers.realTimeDatabase.get<Map>(
      ref,
    );
    if (snapshot.isEmpty) return [];
    final students = Mapper.mapToListFromFirebaseSnapshot(
      snapshot: snapshot,
      fromJson: StudentModel.fromJson,
      idFieldName: 'uid',
      containsId: true,
    );

    return students;
  }

  @override
  Future<void> checkStudents({
    required CheckParams params,
  }) async {
    String checkStudentRef = DatabaseReference.checkStudent(params.uid);
    // String checkStudentRef = DatabaseReference.checks(params.uid);
    Map<String, dynamic> data = {};
    final checkInMap = params.checkInToMap();
    final checkOutMap = params.checkOutToMap();
    final absencesMap = params.absenceToMap();
    switch (params.check) {
      case "absences":
        data = absencesMap;

      case "present":
        data = checkInMap;

      case "leave":
        data = checkOutMap;
    }

    await Managers.realTimeDatabase.update(
      ref: checkStudentRef,
      data: data,
    );
    if (params.check == "absences") {
      await addStudentAbsence(params.uid);
    } else {
      await removeStudentAbsence(params.uid);
    }
  }

  Future<void> addStudentAbsence(String studentId) async {
    String absenseStudentRef = DatabaseReference.absenseStudent(studentId);
    final today = DatabaseReference.today;

    final List<Object?> snapshot =
        await Managers.realTimeDatabase.get<List<Object?>>(absenseStudentRef);
    List<String> data = snapshot.map((e) => e.toString()).toList();

    List<String> currentAbsences = [];
    if (snapshot.isNotEmpty) {
      currentAbsences = data;
    }

    if (!currentAbsences.contains(today)) {
      currentAbsences.add(today);
      await Managers.realTimeDatabase
          .set(ref: absenseStudentRef, data: currentAbsences);
      Logger().i('Added $today to absences on ' ' in Firebase');
    }
  }

  Future<void> removeStudentAbsence(String studentId) async {
    final today = DatabaseReference.today;
    String absenseStudentRef = DatabaseReference.absenseStudent(studentId);
    final List<Object?> snapshot =
        await Managers.realTimeDatabase.get<List<Object?>>(absenseStudentRef);

    List<String> currentAbsences =
        snapshot.isNotEmpty ? snapshot.map((e) => e.toString()).toList() : [];

    if (currentAbsences.contains(today)) {
      currentAbsences.remove(today);
      await Managers.realTimeDatabase
          .set(ref: absenseStudentRef, data: currentAbsences);
      Logger().i('Removed $today from absences on ' ' in Firebase');
    }
  }

  @override
  Future<List<String>> getAbsences() async {
    String absenseStudentRef = DatabaseReference.absenseStudent('');
    final List<Object?> snapshot =
        await Managers.realTimeDatabase.get<List<Object?>>(absenseStudentRef);

    List<String> currentAbsences =
        snapshot.isNotEmpty ? snapshot.map((e) => e.toString()).toList() : [];
    return currentAbsences;
  }

  @override
  Future<List<StudentEntity>> fetchChecks() async {
    String ref = DatabaseReference.checksdetails;
    final snapshot = await Managers.realTimeDatabase.get(
      ref,
    );
    // if (snapshot.isEmpty) return [];
    final students = Mapper.mapToListFromFirebaseSnapshot(
      snapshot: snapshot,
      fromJson: StudentModel.fromJson,
      idFieldName: 'uid',
      containsId: true,
    );

    return students;
  }
}
