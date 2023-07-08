import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final Color? foregroundColor;
  const AppIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }
}
