import 'package:a_school_app/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      this.hint,
      this.controller,
      this.validator,
      this.onSaved,
      this.backgroundColor,
      this.width,
      this.height,
      this.enabled,
      this.maxLines,
      this.suffixIcon,
      this.onChanged,
      this.focusNode,
      this.isPassword = false,
      this.keyboardType,
      this.readOnly});

  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final bool? enabled;
  final int? maxLines;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            child: Container(
                width: widget.width ?? context.width,
                height: widget.height,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7.h)),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: TextFormField(
                        enabled: widget.enabled ?? true,
                        controller: widget.controller,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          errorStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: AppColors.red, // Change text color here
                              ),
                          border: InputBorder.none,
                          hintText: widget.hint,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primary), // Normal state
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.blue,
                                width: 2.w), // Focus state
                          ),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color:
                                    AppColors.primary, // Change text color here
                              ),
                          suffixIcon: widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                    Icons.visibility,
                                    color: AppColors.primary,
                                    size: 20.sp,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                )
                              : const Offstage(),
                        ),
                        onSaved: widget.onSaved,
                        validator: widget.validator,
                        maxLines: 1,
                        obscureText: widget.isPassword ? obscureText : false,
                        onChanged: widget.onChanged,
                        focusNode: widget.focusNode,
                        keyboardType: widget.keyboardType,
                        readOnly: widget.readOnly ?? false)))));
  }
}
