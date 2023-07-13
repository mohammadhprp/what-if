import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/app/app_assets.dart';
import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../helpers/storage/local_directory.dart';

class ImageFileView extends StatelessWidget {
  final String? image;
  final String dir;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;
  final Border? border;

  const ImageFileView({
    super.key,
    required this.image,
    required this.dir,
    this.height,
    this.width,
    this.radius,
    this.fit,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return ImageFilePalaceHolder(
        height: height,
        width: width,
        radius: radius,
        fit: fit,
        border: border,
      );
    }
    return FutureBuilder(
      future: LocalDirectory.get(dir: dir, name: image!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ImageFilePalaceHolder(
            height: height,
            width: width,
            radius: radius,
            fit: fit,
            border: border,
          );
        }

        final image = snapshot.requireData;
        return ImageFileViewer(
          image: image,
          height: height,
          width: width,
          radius: radius,
          fit: fit,
          border: border,
        );
      },
    );
  }
}

class ImageFilePalaceHolder extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;
  final Border? border;
  const ImageFilePalaceHolder({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.fit,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.width * 0.4,
      height: height ?? context.height * 0.2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        image: const DecorationImage(
          image: AssetImage(AppAssets.logo),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class ImageFileViewer extends StatelessWidget {
  final File image;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;
  final Border? border;
  const ImageFileViewer({
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
    return Container(
      width: width ?? context.width * 0.4,
      height: height ?? context.height * 0.2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        image: DecorationImage(
          image: FileImage(image),
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
