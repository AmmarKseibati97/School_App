import 'package:flutter/material.dart';
import '../../config/local/app_localizations.dart';
import '../utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/strings.dart';

class Ui {
  static Future customAlertDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required void Function() onPressed,
      Color? actionColor,
      Color? titleColor}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: TextStyle(
                  fontSize: 20.sp, color: titleColor ?? AppColors.black)),
          content: Text(content,
              style: TextStyle(fontSize: 15.sp, color: AppColors.black)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                  AppLocalizations.of(context)!.translate('cancel') ??
                     Strings.translationError,
                  style: TextStyle(fontSize: 15.sp, color: AppColors.primary)),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(title,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: actionColor ?? AppColors.primary)),
            ),
          ],
        );
      },
    );
  }
}
