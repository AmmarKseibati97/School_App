import 'package:a_school_app/config/local/app_localizations.dart';
import 'package:a_school_app/config/routes/routes.dart';
import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/core/utils/images.dart';
import 'package:a_school_app/core/utils/strings.dart';
import 'package:a_school_app/features/absence/presentation/view/absence_view.dart';
import 'package:a_school_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:a_school_app/features/splash_screen/presentation/cubit/local_cubit.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:a_school_app/features/students/presentation/bloc/student_bloc.dart';
import 'package:a_school_app/features/students/presentation/widgets/search_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsView extends StatefulWidget {
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  late ValueNotifier<List<StudentEntity>> filteredStudents;
  late ValueNotifier<List<StudentEntity>> allStudents;
  void _filterStudents(String searchQuery) {
    filteredStudents.value = allStudents.value
        .where((student) =>
            student.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    allStudents = ValueNotifier([]);
    filteredStudents = ValueNotifier([]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<StudentBloc>()..add(const StudentEvent.fetchStudents()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title:
              Text(AppLocalizations.of(context)?.translate('students') ?? ''),
          centerTitle: true,
        ),
        body: BlocConsumer<StudentBloc, StudentState>(
          listener: (context, state) {
            state.maybeWhen(
              studentsFetched: (students) {
                allStudents.value = students;
                filteredStudents.value = allStudents.value;
              },
              orElse: () {},
            );
          },
          buildWhen: (previous, current) {
            if (current.runtimeType ==
                const StudentState.initial().runtimeType) {
              return false;
            }
            return true;
          },
          builder: (context, state) => state.maybeWhen(
              orElse: () => const Offstage(),
              initial: () => const Offstage(),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (_) => const Offstage(),
              empty: () => const Offstage(),
              studentsFetched: (students) {
                return Column(
                  children: [
                    SearchField(
                      hintText: AppLocalizations.of(context)
                              ?.translate('search_field_hint') ??
                          '',
                      onChanged: (p0) {
                        _filterStudents(p0);
                      },
                    ),
                    SizedBox(height: 14.h),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: ValueListenableBuilder(
                          valueListenable: filteredStudents,
                          builder: (context, filtered, child) =>
                              GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.w,
                                    mainAxisSpacing: 24.h,
                                    mainAxisExtent: 243.h,
                                  ),
                                  itemCount: filtered.length,
                                  itemBuilder: (context, index) {
                                    final student = filtered[index];
                                    return buildStudentCard(student);
                                  }),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  buildStudentCard(StudentEntity student) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AbsenceView(
                      student: student,
                    )));
      },
      child: Directionality(
        textDirection:
            context.read<LocaleCubit>().currentLangCode == Strings.englishCode
                ? TextDirection.ltr
                : TextDirection.rtl,
        child: Container(
          alignment: Alignment.topCenter,
          width: 164.w,
          decoration: BoxDecoration(
              color: AppColors.studentCard,
              borderRadius: BorderRadius.circular(8.sp)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      student.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.yellowAccent,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 9.w,
                      width: 9.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getCurrentStatus(student.checkStatus)),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                color: Colors.yellowAccent,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 17.h,
                ),
                child: CircleAvatar(
                  radius: 38.r,
                  backgroundImage: const AssetImage(
                    Images.unknownPerson,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  top: 28.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.translate('id') ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.yellowAccent,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      student.uid,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.yellowAccent,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getCurrentStatus(String status) {
    if (status == ChecksType.absences.name) {
      return Colors.red;
    }
    if (status == ChecksType.present.name) {
      return Colors.green;
    }
    if (status == ChecksType.leave.name) {
      return Colors.orange;
    }
  }
}
