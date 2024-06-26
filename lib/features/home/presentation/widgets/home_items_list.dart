import 'package:a_school_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/local/app_localizations.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/strings.dart';
import '../../data/models/home_item_model.dart';

List<HomeItemModel> homeItems(BuildContext context) {
  List<HomeItemModel> onBoardingList = [
    HomeItemModel(
        title: AppLocalizations.of(context)!.translate('students_list') ??
            Strings.translationError,
        icon: Images.studentsListImage,
        onTap: () {}),
    HomeItemModel(
      title: AppLocalizations.of(context)!.translate('absent_manag') ??
          Strings.translationError,
      icon: Images.absenceIcon,
      onTap: () {},
    ),
    HomeItemModel(
      title: AppLocalizations.of(context)!.translate('attend_summary') ??
          Strings.translationError,
      icon: Images.attendanceIcon,
      onTap: () {},
    ),
    HomeItemModel(
        title: AppLocalizations.of(context)!.translate('logout') ??
            Strings.translationError,
        icon: Images.logoutImage,
        onTap: () async {
          context.read<AuthBloc>().add(const AuthEvent.signOut());
          Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_) {
            return true;
          });
        }),
  ];
  return onBoardingList;
}
