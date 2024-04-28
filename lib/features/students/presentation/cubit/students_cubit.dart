import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'students_state.dart';

@injectable
class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(StudentsInitial());
}
