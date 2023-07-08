import 'package:flutter/material.dart';

import 'animation_view.dart';

class LoadingAnimationView extends AnimationView {
  const LoadingAnimationView({super.key})
      : super(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
}
