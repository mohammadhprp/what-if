import 'package:flutter/material.dart';

import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../constants/values_manager/values_manager.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? height;
  final double? width;
  final ButtonStyle? style;
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height,
    this.width,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      height: height ?? AppSize.s60,
      child: ElevatedButton(
        style: style ??
            ElevatedButton.styleFrom(
              disabledBackgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
            ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
