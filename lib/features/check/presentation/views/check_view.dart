import 'package:a_school_app/config/local/app_localizations.dart';
import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/core/utils/strings.dart';
import 'package:a_school_app/features/check/presentation/widgets/checks.dart';
import 'package:a_school_app/features/splash_screen/presentation/cubit/local_cubit.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:a_school_app/features/students/presentation/bloc/student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;

class CheckView extends StatefulWidget {
  const CheckView({super.key});

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)?.translate('check_in_out') ?? ''),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: BlocBuilder<StudentBloc, StudentState>(
                buildWhen: (previous, current) {
                  if (current.runtimeType ==
                      const StudentState.studentsFetched().runtimeType) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) => state.maybeWhen(
                    orElse: () => const Offstage(),
                    initial: () => const Offstage(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    failure: (_) => const Offstage(),
                    empty: () => const Offstage(),
                    studentsFetched: (students) {
                      return buildStudentsChecks(students);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('d MMMM - yyyy, HH:mm').format(dateTime);
  }

  buildStudentsChecks(List<StudentEntity> students) {
    return ListView.builder(
        itemCount: students.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final StudentEntity student = students[index];

          final String today = DateTime.now().toIso8601String();

          return Directionality(
            textDirection: context.read<LocaleCubit>().currentLangCode ==
                    Strings.englishCode
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Container(
              margin: EdgeInsets.only(top: 15.h),
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              height: 102.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.5.sp,
                  color: Colors.black.withOpacity(0.25),
                ),
                borderRadius: BorderRadius.circular(5.sp),
              ),
              child: Column(
                children: [
                  Text(
                    student.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xff4F5054),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Column(
                    children: [
                      Checks(
                          today: today,
                          checkedInAt: student.checkedInAt,
                          checkedOutAt: student.checkedOutAt,
                          leaveAt: student.leaveAt,
                          status: student.checkStatus,
                          isChecked:
                              ChecksType.absences.name == student.checkStatus,
                          uid: student.uid),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CheckDetials {
  final bool isChecked;
  final String date;
  final String uid;

  CheckDetials({
    required this.isChecked,
    required this.date,
    required this.uid,
  });
}
