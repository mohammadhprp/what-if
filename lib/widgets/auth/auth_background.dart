import 'package:flutter/material.dart';

import '../../constants/app/app_colors.dart';
import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../constants/values_manager/values_manager.dart';

class AuthBackground extends StatelessWidget {
  final Widget content;
  const AuthBackground({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p18),
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          topRight: Radius.circular(AppSize.s12),
        ),
        color: AppColors.grey08,
      ),
      child: SingleChildScrollView(child: content),
    );
  }
}
