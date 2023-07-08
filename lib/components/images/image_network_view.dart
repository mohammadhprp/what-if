import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app/app_colors.dart';
import '../../constants/app/app_icons.dart';
import '../../constants/values_manager/values_manager.dart';
import '../animations/loading_animation_view.dart';
import '../icon/icon_view.dart';

class ImageNetworkView extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;
  final Border? border;

  const ImageNetworkView({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.radius,
    this.fit,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? AppSize.s0),
          ),
          border: border,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? AppSize.s0),
          ),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: fit,
            placeholder: (context, url) => const LoadingAnimationView(),
            errorWidget: (context, url, error) => const IconView(
              icon: AppIcons.infoCircle,
              color: AppColors.error,
            ),
          ),
        ),
      ),
    );
  }
}
