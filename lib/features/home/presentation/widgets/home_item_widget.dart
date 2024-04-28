import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../data/models/home_item_model.dart';

class HomeItemWidget extends StatelessWidget {
  final HomeItemModel item;

  const HomeItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: item.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  item.icon,
                  height: 50.h,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.black, // Change text color here
                      ),
                ),
              ],
            ),
            Image.asset(
              Images.polygonIcon,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
