import 'package:flutter/material.dart';

class VerticalDivider extends StatelessWidget {
  final Color? color;
  const VerticalDivider({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 45,
      width: 1,
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }
}
