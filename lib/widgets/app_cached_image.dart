import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  String picUrl;
  double? picRadius;
  AppCachedImage({
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
        return CircularProgressIndicator(
          value: progress.progress,
        );
      },
    );
  }
}
