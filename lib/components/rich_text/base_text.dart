import 'package:flutter/material.dart' show immutable, TextStyle, VoidCallback;

import '../../constants/app/app_colors.dart';
import '../../constants/values_manager/font_manager.dart';
import 'link_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(
        text: text,
        style: style,
      );

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeightManager.bold,
    ),
  }) =>
      LinkText(
        text: " $text ",
        onTapped: onTapped,
        style: style,
      );
}
