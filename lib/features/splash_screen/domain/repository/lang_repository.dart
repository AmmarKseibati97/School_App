import 'package:a_school_app/core/error/local_failure.dart';
import 'package:dartz/dartz.dart';

abstract class LangRepository {
  Future<Either<LocalFailure, bool>> changeLang({required String langCode});

  Future<Either<LocalFailure, String>> getSavedLang();
}
