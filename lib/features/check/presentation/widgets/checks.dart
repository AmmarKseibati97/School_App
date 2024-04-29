import 'package:a_school_app/config/local/app_localizations.dart';
import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/core/utils/images.dart';
import 'package:a_school_app/core/utils/strings.dart';
import 'package:a_school_app/features/check/params/check_params.dart';
import 'package:a_school_app/features/splash_screen/presentation/cubit/local_cubit.dart';
import 'package:a_school_app/features/students/presentation/bloc/student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Checks extends StatefulWidget {
  const Checks({
    super.key,
    required this.isChecked,
    required this.uid,
    required this.status,
    required this.checkedInAt,
    required this.checkedOutAt,
    required this.leaveAt,
    required this.today,
  });

  final bool isChecked;
  final String uid;
  final String status;
  final String checkedInAt;
  final String checkedOutAt;
  final String leaveAt;
  final String today;

  @override
  State<Checks> createState() => _ChecksState();
}

class _ChecksState extends State<Checks> {
  late ValueNotifier<String> _isChecked;
  late List<Widget> items;
  late List<e> dataItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isChecked = ValueNotifier<String>(widget.status);
    dataItems = initilaItems(context);
    items = getItems();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _isChecked,
      builder: (context, value, child) {
        items = getItems();
        return Column(
          children: items,
        );
      },
    );
  }

  List<e> initilaItems(BuildContext context) => [
        // e(
        //   backGroundColor: Colors.red.withOpacity(0.3),
        //   textColor: Colors.red,
        //   text: AppLocalizations.of(context)?.translate('absences') ?? '',
        //   title: AppLocalizations.of(context)?.translate('absent_on') ?? '',
        //   status: ChecksType.absences.name,
        //   date: widget.leaveAt,
        //   uid: widget.uid,
        // ),
        e(
          backGroundColor: Colors.green.withOpacity(0.3),
          textColor: Colors.green,
          text: AppLocalizations.of(context)?.translate('present') ?? '',
          title: AppLocalizations.of(context)?.translate('present_on') ?? '',
          status: ChecksType.present.name,
          date: widget.checkedInAt,
          uid: widget.uid,
        ),
        e(
          backGroundColor: Colors.orange.withOpacity(0.3),
          textColor: Colors.orange,
          text: AppLocalizations.of(context)?.translate('leave') ?? '',
          title: AppLocalizations.of(context)?.translate('leave_on') ?? '',
          status: ChecksType.leave.name,
          date: widget.checkedOutAt,
          uid: widget.uid,
        )
      ];

  List<Widget> getItems() {
    List<Widget> items = [];
    items.addAll(dataItems.map((e) {
      final isShown = format(e.date) == format(widget.today);
      final showDate = e.status != ChecksType.absences.name
          ? formatDate(e.date)
          : format(e.date);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            width: 110.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: e.backGroundColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.text,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: e.textColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600),
                ),
                Transform.scale(
                  scale: 0.68,
                  child: ValueListenableBuilder(
                    valueListenable: _isChecked,
                    builder: (context, value, child) => Radio<String>(
                      key: ValueKey(_isChecked),
                      toggleable: true,
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: e.status,
                      groupValue: isShown ? value : '',
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _isChecked.value = newValue;

                            final elementIndex = dataItems
                                .indexWhere((item) => item.status == newValue);
                            if (elementIndex != -1) {
                              dataItems[elementIndex].date = widget.today;
                            }
                            context
                                .read<StudentBloc>()
                                .add(StudentEvent.checkStudent(
                                    params: CheckParams(
                                  uid: widget.uid,
                                  check: newValue,
                                )));
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 0.58.sw,
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: context.read<LocaleCubit>().currentLangCode ==
                        Strings.englishCode
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  Text(
                    isShown ? showDate : '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xff4F5054),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    e.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xffA4A4A5),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8.w),
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColors.studentCard,
                    child: Image.asset(
                      color: Colors.white,
                      height: 14.w,
                      width: 15.w,
                      Images.calendarIcon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }));
    return items;
  }

  String formatDate(String dateStr) {
    return dateStr.replaceAll('T', ' ').split('.').first;
  }

  String format(String dateStr) {
    return dateStr.split('T').first;
  }
}

class e {
  final Color backGroundColor;
  final Color textColor;
  final String text;
  final String title;
  final String status;
  String date;
  final String uid;

  e({
    required this.backGroundColor,
    required this.textColor,
    required this.text,
    required this.title,
    required this.status,
    required this.date,
    required this.uid,
  });
}
