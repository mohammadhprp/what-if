import 'package:flutter/material.dart';

import '../../constants/app/app_colors.dart';

class HorizontalDivider extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  const HorizontalDivider({
    super.key,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.grey200,
      indent: width,
      endIndent: width,
      thickness: height,
    );
  }
}
