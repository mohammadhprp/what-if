// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/app/app_colors.dart';
import '../../constants/app/app_icons.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../helpers/localization/app_local.dart';
import '../buttons/elevated_button.dart';
import '../icon/icon_view.dart';
import 'error_controller.dart';

//* Show loading screen
// ErrorScreen.instance().show(context: context,text: pleaseWait);

//* Hide loading screen
// ErrorScreen.instance().hide();

class ErrorScreen {
  ErrorScreen._sharedInstance();
  static final ErrorScreen _shared = ErrorScreen._sharedInstance();
  factory ErrorScreen.instance() => _shared;

  ErrorController? _controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    }
    _controller = _showOverlay(context: context, text: text);
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  ErrorController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Theme.of(context).colorScheme.background.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.s16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: AppSize.s10),
                      const IconView(
                        icon: AppIcons.infoCircle,
                        color: AppColors.error,
                        height: AppSize.s40,
                      ),
                      const SizedBox(height: AppSize.s20),
                      Text(
                        'error.an_error_happened',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSize.s15),
                      StreamBuilder<String>(
                        stream: _text.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            );
                          }
                          return Container();
                        },
                      ),
                      const SizedBox(height: AppSize.s35),
                      AppElevatedButton(
                        height: AppSize.s45,
                        onPressed: () {
                          hide();
                        },
                        child: Text(AppLocal.tr(context, 'button.ok')),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    state.insert(overlay);
    return ErrorController(
      close: () {
        _text.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        _text.add(text);
        return true;
      },
    );
  }
}
