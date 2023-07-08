import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../values_manager/font_manager.dart';
import '../values_manager/styles_manager.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData dark() => FlexThemeData.dark(
        useMaterial3: true,
        fontFamily: FontConstants.primary,
        scheme: FlexScheme.greenM3,
        primary: AppColors.primary,

        subThemesData: const FlexSubThemesData(
          interactionEffects: false,
          chipSchemeColor: SchemeColor.primary,
          elevatedButtonSchemeColor: SchemeColor.onPrimary,
          elevatedButtonSecondarySchemeColor: SchemeColor.primary,
          elevatedButtonElevation: 0,
          elevatedButtonRadius: 12,
          outlinedButtonSchemeColor: SchemeColor.onPrimary,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          outlinedButtonRadius: 12,
          cardElevation: 0,
          menuElevation: 0,
          dialogElevation: 0,
          drawerElevation: 0.4,
          menuBarElevation: 0,
          snackBarElevation: 0,
          popupMenuElevation: 0,
          drawerRadius: 0,
          appBarScrolledUnderElevation: 0,
        ),

        // Text theme
        textTheme: TextTheme(
          displayLarge: getBlackStyle(
            color: AppColors.primary,
            fontSize: FontSize.s25,
          ),
          displayMedium: getExtraBoldStyle(
            color: AppColors.white100,
            fontSize: FontSize.s17,
          ),
          displaySmall: getMediumStyle(
            color: AppColors.grey100,
            fontSize: FontSize.s16,
          ),
          titleLarge: getBoldStyle(
            color: AppColors.white100,
            fontSize: FontSize.s15,
          ),
          titleMedium: getRegularStyle(
            color: AppColors.white100,
            fontSize: FontSize.s14,
          ),
          titleSmall: getLightStyle(
            color: AppColors.grey100,
            fontSize: FontSize.s14,
          ),
          bodyLarge: getMediumStyle(
            color: AppColors.white100,
            fontSize: FontSize.s15,
          ),
          bodyMedium: getMediumStyle(
            color: AppColors.white100,
            fontSize: FontSize.s14,
          ),
          bodySmall: getUltraLightStyle(
            color: AppColors.grey100,
            fontSize: FontSize.s13,
          ),
        ),
      );
}
