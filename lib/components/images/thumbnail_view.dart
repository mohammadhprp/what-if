import 'package:flutter/material.dart';

import '../../constants/values_manager/values_manager.dart';
import 'image_network_view.dart';

class ThumbnailView extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final Border? border;
  final double radius;

  const ThumbnailView({
    super.key,
    required this.image,

    /// By default is 60
    this.height = AppSize.s60,

    /// By default is 60
    this.width = AppSize.s60,

    /// By default is NULL
    this.border,

    /// By default value 12
    this.radius = AppSize.s12,
  });

  @override
  Widget build(BuildContext context) {
    return ImageNetworkView(
      image: image,
      height: height,
      width: width,
      border: border,
      radius: radius,
      fit: BoxFit.cover,
    );
  }
}
