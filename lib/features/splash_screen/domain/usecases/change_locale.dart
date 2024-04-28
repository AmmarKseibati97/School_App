import 'package:a_school_app/core/error/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/lang_repository.dart';

@lazySingleton
class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<LocalFailure, bool>> call(String langCode) async =>
      await langRepository.changeLang(langCode: langCode);
}
