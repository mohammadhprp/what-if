// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/app/app_colors.dart';
import '../../constants/app/app_icons.dart';
import '../../constants/extensions/theme/theme_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../icon/icon_view.dart';
import 'toast_message_controller.dart';

//* Show Toast message
// ToastMessageView.instance().show(context: context,text: message);

//* Hide Toast message
// ToastMessageView.instance().hide();

enum ToastMessageType {
  info,
  error,
  warning,
}

enum ToastMessagePosition {
  top,
  button,
}

class ToastMessageView {
  ToastMessageView._sharedInstance();
  static final ToastMessageView _shared = ToastMessageView._sharedInstance();
  factory ToastMessageView.instance() => _shared;

  ToastMessageController? _controller;

  void show({
    required BuildContext context,
    required String text,
    Duration duration = const Duration(seconds: 3),
    ToastMessageType type = ToastMessageType.error,
    ToastMessagePosition position = ToastMessagePosition.top,
  }) {
    _controller = _showOverlay(
      context: context,
      text: text,
      duration: duration,
      type: type,
      position: position,
    );

    Future.delayed(duration, () => hide());
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  ToastMessageController _showOverlay({
    required BuildContext context,
    required String text,
    required Duration duration,
    required ToastMessageType type,
    required ToastMessagePosition position,
  }) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context);

    String? icon;
    Color? backgroundColor;
    ToastGravity? toastGravity;

    const kDefaultBoxShadow = [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 8),
        spreadRadius: AppSize.s1,
        blurRadius: AppSize.s30,
      ),
    ];

    switch (type) {
      case ToastMessageType.error:
        backgroundColor = AppColors.error.withOpacity(0.8);
        icon = AppIcons.closeCircle;
        break;
      case ToastMessageType.info:
        backgroundColor = AppColors.warning.withOpacity(0.8);
        icon = AppIcons.infoCircle;
        break;

      case ToastMessageType.warning:
        backgroundColor =
            context.theme.colorScheme.onBackground.withOpacity(0.8);
        icon = AppIcons.infoCircle;
        break;
    }

    switch (position) {
      case ToastMessagePosition.top:
        toastGravity = ToastGravity.TOP;
        break;
      case ToastMessagePosition.button:
        toastGravity = ToastGravity.BOTTOM;
        break;
    }

    fToast.showToast(
      gravity: toastGravity,
      toastDuration: duration,
      child: Container(
        height: AppSize.s65,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSize.s12),
          ),
          boxShadow: kDefaultBoxShadow,
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -AppSize.s10,
              left: -AppSize.s8,
              child: SizedBox(
                height: AppSize.s90,
                child: Transform.rotate(
                  angle: AppSize.s32 * pi / AppSize.s180,
                  child: IconView(
                    icon: icon,
                    color: const Color(0x15000000),
                    height: AppSize.s120,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s24),
                child: Text(
                  text,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return ToastMessageController(
      close: () {
        Fluttertoast.cancel();
        return true;
      },
    );
  }
}
