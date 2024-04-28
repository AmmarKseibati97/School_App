import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.width,
      required this.backgroundColor,
      this.fontSize});

  final String title;
  final Color backgroundColor;
  final double? width;
  final VoidCallback onPressed;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white, // Change text color here
                ),
          ),
        ));
  }
}
