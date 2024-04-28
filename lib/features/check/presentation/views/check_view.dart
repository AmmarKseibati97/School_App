import 'package:a_school_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CheckView extends StatefulWidget {
  const CheckView({super.key});

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
    );
  }
}
