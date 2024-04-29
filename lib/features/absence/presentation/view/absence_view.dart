import 'package:a_school_app/config/local/app_localizations.dart';
import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/core/utils/images.dart';
import 'package:a_school_app/features/check/params/check_params.dart';
import 'package:a_school_app/features/students/domain/entities/student_entity.dart';
import 'package:a_school_app/features/students/presentation/bloc/student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AbsenceView extends StatefulWidget {
  const AbsenceView({super.key, this.student});
  final StudentEntity? student;

  @override
  State<AbsenceView> createState() => _AbsenceViewState();
}

class _AbsenceViewState extends State<AbsenceView> {
  late final ValueNotifier<String?> absenceDate;
  @override
  void initState() {
    super.initState();
    absenceDate = ValueNotifier<String?>(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)?.translate('absent_manag') ?? ''),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
          Text(
            widget.student!.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700),
          ),
          SfCalendar(
            showNavigationArrow: true,
            view: CalendarView.month,
            onTap: (calendarTapDetails) {
              absenceDate.value =
                  calendarTapDetails.date?.toIso8601String().split('T').first;
            },
            dataSource: MeetingDataSource(_getDataSource(widget.student!)),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                agendaItemHeight: 0.1),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: AppColors.primary,
                elevation: 500,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text(
                'Mark Absence',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                getIt<StudentBloc>().add(StudentEvent.checkStudent(
                    params: CheckParams(
                  uid: widget.student?.uid ?? '',
                  check: ChecksType.absences.name,
                )));
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource(StudentEntity studentEntity) {
    List<Meeting> meetings = <Meeting>[];

    meetings = studentEntity.absenceDates.map((e) {
      final date = DateTime.parse(e);

      return Meeting(
        'absence',
        DateTime(date.year, date.month, date.day),
        DateTime(date.year, date.month, date.day).add(const Duration(days: 0)),
        Colors.red,
        true,
      );
    }).toList();
    meetings = List.from(meetings);

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
}
