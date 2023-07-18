import 'package:flutter/material.dart';

import '../../../../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../../../../constants/extensions/theme/theme_extension.dart';
import '../../../../../../constants/values_manager/values_manager.dart';

class ImageGeneratorPlaceHolder extends StatelessWidget {
  final Widget child;
  const ImageGeneratorPlaceHolder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.height * 0.4,
      width: context.width,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: child,
    );
  }
}
