import 'package:a_school_app/core/error/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exeption.dart';
import '../../domain/repository/lang_repository.dart';
import '../endpoint/lang_local_data_source.dart';

@LazySingleton(as: LangRepository)
class LangRepositoryImpl extends LangRepository {
  final LangLocalDataSource langLocalDataSource;

  LangRepositoryImpl({
    required this.langLocalDataSource,
  });

  @override
  Future<Either<LocalFailure, bool>> changeLang(
      {required String langCode}) async {
    try {
      final value = await langLocalDataSource.changeLang(langCode: langCode);
      return Right(value);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<LocalFailure, String>> getSavedLang() async {
    try {
      final value = await langLocalDataSource.getSavedLang();
      return Right(value!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
