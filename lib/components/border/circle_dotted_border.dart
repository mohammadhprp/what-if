import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constants/values_manager/values_manager.dart';

class CircleDottedBorder extends StatelessWidget {
  final Widget child;
  final Color? color;
  const CircleDottedBorder({
    super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [7, 3],
      borderType: BorderType.Circle,
      strokeWidth: AppSize.s1_5,
      padding: const EdgeInsets.all(AppPadding.p10),
      color: color ?? Theme.of(context).primaryColor,
      child: child,
    );
  }
}
