import 'package:a_school_app/features/absence/presentation/view/absence_view.dart';
import 'package:a_school_app/features/check/presentation/views/check_view.dart';
import 'package:a_school_app/features/students/presentation/views/students_view.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../home/presentation/views/home_view.dart';

part 'root_state.dart';

@injectable
class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootInitial());
  int currentIndex = 0;

  List<Widget> pagesSet() {
    List<Widget> pages = [
      const HomeView(),
      const StudentsView(),
      const CheckView(),
    ];
    return pages;
  }

  Widget get currentPage => pagesSet()[currentIndex];

  Future<void> changePage(int index) async {
    await changePageOutRoot(index);
    emit(RootChangedState(index));
  }

  Future<void> changePageOutRoot(int index) async {
    currentIndex = index;
  }
}
