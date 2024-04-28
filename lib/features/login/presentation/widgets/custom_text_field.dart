import 'package:a_school_app/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
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
      this.obscureText = false,
      this.suffixIcon,
      this.onChanged,
      this.focusNode,
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
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            child: Container(
                width: width ?? context.width,
                height: height,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7.h)),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: TextFormField(
                        enabled: enabled ?? true,
                        controller: controller,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            errorStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      AppColors.red, // Change text color here
                                ),
                            border: InputBorder.none,
                            hintText: hint,
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
                                  color: AppColors
                                      .primary, // Change text color here
                                ),
                            suffixIcon: suffixIcon),
                        onSaved: onSaved,
                        validator: validator,
                        maxLines: obscureText == true ? 1 : maxLines,
                        obscureText: obscureText,
                        onChanged: onChanged,
                        focusNode: focusNode,
                        keyboardType: keyboardType,
                        readOnly: readOnly ?? false)))));
  }
}
