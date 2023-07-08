import 'package:flutter/material.dart';

import '../../constants/app/app_assets.dart';
import '../images/image_asset_view.dart';

class AppLogo extends StatelessWidget {
  final double height;
  final double width;
  const AppLogo({
    super.key,
    this.height = 200,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return ImageAssetView(
      height: height,
      width: width,
      image: AppAssets.logo,
    );
  }
}
