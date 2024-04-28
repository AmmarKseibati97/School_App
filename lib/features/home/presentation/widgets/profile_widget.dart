import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return      Row(
      children: [
        CircleAvatar(
          radius: 25.r,
          child: Image.asset(
            Images.unknownPerson,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ammar Ahmed',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                color:
                AppColors.black, // Change text color here
              ),
            ),
            Text(
              'Ammar@aschool.com',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                color:
                AppColors.black, // Change text color here
              ),
            )
          ],
        )
      ],
    );
  }
}
