import 'package:a_school_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/local/app_localizations.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/custom_alert_dialog.dart';
import '../cubit/root_cubit.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late RootCubit rootCubit = BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootCubit, RootState>(
        builder: (context, state) => WillPopScope(
            onWillPop: () async {
              bool exit = await Ui.customAlertDialog(
                  context: context,
                  title: AppLocalizations.of(context)!.translate('exit_app') ??
                      Strings.translationError,
                  content: AppLocalizations.of(context)!
                          .translate('exit_app_content') ??
                      Strings.translationError,
                  onPressed: () => Navigator.of(context).pop(true));
              return exit;
            },
            child: Scaffold(
              body: rootCubit.currentPage,
              bottomNavigationBar: CustomBottomNavigationBar(
                backgroundColor: AppColors.white,
                itemColor: AppColors.primary,
                currentIndex: rootCubit.currentIndex,
                onChange: (index) {
                  index == rootCubit.currentIndex
                      ? null
                      : rootCubit.changePage(index);
                },
                children: [
                  CustomBottomNavigationItem(
                    icon: Icons.home_outlined,
                    label: AppLocalizations.of(context)!.translate('home') ??
                        Strings.translationError,
                    color: AppColors.primary,
                  ),
                  CustomBottomNavigationItem(
                    icon: Icons.perm_contact_calendar_sharp,
                    label:
                        AppLocalizations.of(context)!.translate('students') ??
                            Strings.translationError,
                    color: AppColors.primary,
                  ),
                  CustomBottomNavigationItem(
                    icon: Icons.check_circle,
                    label: AppLocalizations.of(context)!
                            .translate('check_in_out') ??
                        Strings.translationError,
                    color: AppColors.primary,
                  ),
                ],
              ),
            )));
  }
}
