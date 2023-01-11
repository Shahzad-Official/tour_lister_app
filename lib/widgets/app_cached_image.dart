import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';

import '../constants/app_colors.dart';

class AppCircularCachedImage extends StatelessWidget {
  String picUrl;
  double? picRadius;
  AppCircularCachedImage({
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
  String picUrl;
  double borderRadius;
  AppCachedImage({
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
            color: AppColors.primarycolor,
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
