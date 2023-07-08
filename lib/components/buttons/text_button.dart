import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? foregroundColor;
  const AppTextButton({
    super.key,
    this.onPressed,
    required this.child,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
      ),
      child: child,
    );
  }
}
