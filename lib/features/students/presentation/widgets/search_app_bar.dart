import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.hintText,
    this.controller,
    this.onSortPressed,
    this.onFilterPressed,
    this.onChanged,
    this.onTap,
  });

  final String? hintText;
  final TextEditingController? controller;
  final void Function()? onFilterPressed;
  final void Function()? onSortPressed;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocus = false;
  late InputBorder? border;

  @override
  void initState() {
    super.initState();
    border = OutlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent),
      borderRadius: BorderRadius.circular(12.sp),
    );
    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      width: 298.w,
      child: TextFormField(
        onTap: widget.onTap,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700),
        controller: widget.controller,
        decoration: InputDecoration(
            filled: true,
            suffixIconConstraints: BoxConstraints(
              maxWidth: 49.w,
              minWidth: 49.w,
            ),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            contentPadding:
                EdgeInsets.only(top: 0, bottom: 0, left: 20.w, right: 20.w),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700),
            fillColor: Color(0xff50499C).withOpacity(0.33),
            focusedBorder: border,
            enabledBorder: border,
            border: border
            // focusedBorder: border,
            ),
      ),
    );
  }
}
