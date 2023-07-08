import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constants/values_manager/values_manager.dart';

class SquareDottedBorder extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double padding;

  const SquareDottedBorder({
    super.key,
    required this.child,
    this.color,
    this.padding = AppPadding.p14,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [7, 10],
      borderType: BorderType.RRect,
      strokeWidth: AppSize.s1_5,
      radius: const Radius.circular(AppSize.s12),
      padding: EdgeInsets.all(padding),
      color: color ?? Theme.of(context).colorScheme.primaryContainer,
      child: child,
    );
  }
}
