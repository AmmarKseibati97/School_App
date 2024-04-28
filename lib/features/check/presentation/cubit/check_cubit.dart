import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'check_state.dart';

@injectable
class CheckCubit extends Cubit<CheckState> {
  CheckCubit() : super(CheckInitial());
}
