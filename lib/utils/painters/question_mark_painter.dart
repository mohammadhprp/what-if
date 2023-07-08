import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../constants/app/app_colors.dart';

class QuestionMarkPainter extends CustomPainter {
  final _fillPaint = Paint()
    ..color = AppColors.primary
    ..strokeWidth = 35
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill;

  final _paint = Paint()
    ..color = AppColors.primary
    ..strokeWidth = 35
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    const startAngle = -math.pi / 1.2;
    const sweepAngle = math.pi * 1.3;
    const useCenter = false;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      useCenter,
      _paint,
    );
    canvas.drawLine(
      Offset(size.width / 2, size.height),
      Offset(size.width / 2, size.height + size.width / 2),
      _fillPaint,
    );

    canvas.drawCircle(
      Offset(size.width / 2, size.height + size.width + 10),
      22,
      _fillPaint,
    );
  }

  @override
  bool shouldRepaint(QuestionMarkPainter oldDelegate) => false;
}
