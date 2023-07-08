import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

// Thin style
TextStyle getThinStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.thin,
    color,
  );
}

// ultra light style
TextStyle getUltraLightStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.ultraLight,
    color,
  );
}

// light text style
TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.light,
    color,
  );
}

// regular text style
TextStyle getRegularStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.regular,
    color,
  );
}

// medium text style
TextStyle getMediumStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.medium,
    color,
  );
}

// Demi bold text style
TextStyle getDemiBoldStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.demiBold,
    color,
  );
}

// bold text style
TextStyle getBoldStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.bold,
    color,
  );
}

// Extra bold text style
TextStyle getExtraBoldStyle({
  double fontSize = FontSize.s16,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.extrabold,
    color,
  );
}

// black text style
TextStyle getBlackStyle({
  double fontSize = FontSize.s16,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.primary,
    FontWeightManager.black,
    color,
  );
}
