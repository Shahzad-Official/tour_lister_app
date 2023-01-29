import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppCircularCachedImage extends StatelessWidget {
  final String picUrl;
  final double? picRadius;
  const AppCircularCachedImage({
    Key? key,
    required this.picUrl,
    this.picRadius = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: picUrl,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: picRadius,
          backgroundImage: imageProvider,
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            value: progress.progress,
            color: AppColors.primarycolor,
          ),
        );
      },
    );
  }
}

class AppCachedImage extends StatelessWidget {
  final String picUrl;
  final double borderRadius;
  const AppCachedImage({
    Key? key,
    required this.picUrl,
    this.borderRadius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: picUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primarycolor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        );
      },
    );
  }
}
