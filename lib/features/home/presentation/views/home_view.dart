import 'package:a_school_app/core/service_locator/injection.dart';
import 'package:a_school_app/core/utils/colors.dart';
import 'package:a_school_app/features/students/presentation/bloc/student_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../config/local/app_localizations.dart';
import '../../../../core/utils/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/strings.dart';
import '../../../splash_screen/presentation/cubit/local_cubit.dart';
import '../widgets/home_items_list_widget.dart';
import '../widgets/profile_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // ChecksRemoteDataSourceImpl().checkStudents(
    //   params: CheckParams(
    //     uid: "S01",
    //     check: true,
    //     checkIn: DateTime.now(),
    //   ),
    // );
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Images.aSchoolImage, color: AppColors.primary),
                SizedBox(height: 30.h),
                const ProfileWidget(),
                SizedBox(height: 30.h),
                Text(
                    AppLocalizations.of(context)!
                            .translate('welcome_to_class') ??
                        Strings.translationError,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.black // Change text color here
                        )),
                SizedBox(height: 30.h),
                const HomeItemsListWidget(),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (AppLocalizations.of(context)!.isEnLocale) {
                            BlocProvider.of<LocaleCubit>(context).toArabic();
                          } else {
                            BlocProvider.of<LocaleCubit>(context).toEnglish();
                          }
                        },
                        icon: const Icon(
                          Icons.translate_outlined,
                          color: Colors.black,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
