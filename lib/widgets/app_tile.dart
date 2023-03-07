import 'package:flutter/material.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';
import 'package:tour_lister_app/widgets/app_text.dart';

class AppTile extends StatelessWidget {
  String picUrl, titleText;
  void Function()? onView, onRemove;
  AppTile({
    Key? key,
    this.picUrl = DummyData.profilePic,
    required this.titleText,
    this.onRemove,
    this.onView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  AppCircularCachedImage(
                    picRadius: 20,
                    picUrl: picUrl,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  AppText(
                    text: titleText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundButton(
                    height: 40,
                    onTap: onView,
                    text: "View",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RoundButton(
                    height: 40,
                    onTap: onRemove,
                    text: "Remove",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
