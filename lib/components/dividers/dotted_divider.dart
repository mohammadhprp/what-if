import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double fillRate; // [0, 1] totalDashSpace/totalSpace
  final Axis direction;

  const DottedDivider({
    Key? key,
    this.height = 1,
    this.width = 8,
    this.color = Colors.black,
    this.fillRate = 0.5,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxSize = direction == Axis.horizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();
        final dCount = (boxSize * fillRate / width).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
          children: List.generate(dCount, (_) {
            return SizedBox(
              width: direction == Axis.horizontal ? width : height,
              height: direction == Axis.horizontal ? height : width,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
