import 'package:a_school_app/core/error/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/lang_repository.dart';

@lazySingleton
class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final LangRepository langRepository;

  GetSavedLangUseCase({required this.langRepository});

  @override
  Future<Either<LocalFailure, String>> call(NoParams params) async =>
      await langRepository.getSavedLang();
}
