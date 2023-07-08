import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../utils/painters/question_mark_painter.dart';

class QuestionMarkAnimation extends HookWidget {
  const QuestionMarkAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 2),
    );
    final animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: QuestionMarkPainter(),
          size: Size(100 * animation.value, 100 * animation.value),
        );
      },
    );
  }
}
