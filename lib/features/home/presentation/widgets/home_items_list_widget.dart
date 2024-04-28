import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';
import '../../data/models/home_item_model.dart';
import 'home_item_widget.dart';
import 'home_items_list.dart';

class HomeItemsListWidget extends StatefulWidget {
  const HomeItemsListWidget({super.key});

  @override
  State<HomeItemsListWidget> createState() => _HomeItemsListWidgetState();
}

class _HomeItemsListWidgetState extends State<HomeItemsListWidget> {
  late List<HomeItemModel> items;

  @override
  Widget build(BuildContext context) {
    items = homeItems(context);
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
      primary: false,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: ((_, index) {
        HomeItemModel item = items.elementAt(index);
        return HomeItemWidget(item: item);
      }),
    );
  }
}
