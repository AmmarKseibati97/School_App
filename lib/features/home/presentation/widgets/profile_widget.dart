import 'package:a_school_app/features/login/domain/entities/teacher_entity.dart';
import 'package:a_school_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late final TeacherEntity? teacher;
  late final String name;
  late final String email;
  @override
  void initState() {
    super.initState();
    teacher = context.read<AuthBloc>().teacher;
    if (teacher != null) {
      name = teacher?.name ?? 'user name';
      email = teacher?.email ?? 'example@gmail.com';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
              name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.black,
                  ),
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.black,
                  ),
            )
          ],
        )
      ],
    );
  }
}
