import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';
import 'package:tour_lister_app/widgets/app_text.dart';

// ignore: must_be_immutable
class SinglePackageContainer extends StatelessWidget {
  String? picUrl;
  String startDate, endDate, eventName, location;
  bool isLive;
  Widget? ratingBar, bottomButton;
  VoidCallback? onEdit, onCancel, onDelete;
  SinglePackageContainer({
    Key? key,
    this.picUrl,
    this.isLive = true,
    this.endDate = "2nd",
    this.startDate = "2nd",
    this.eventName = "Event Culture",
    this.location = "Paris, Europe",
    this.ratingBar,
    this.bottomButton,
    this.onCancel,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ratingBar == null ? 130 : 145,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.backgroundcolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarycolor.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 1.5,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 110,
              decoration: BoxDecoration(
                color: AppColors.primarycolor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: AppCachedImage(
                picUrl: picUrl ?? DummyData.profilePic,
              ),
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bottomButton == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AppText(
                                text: eventName,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            isLive
                                ? Row(
                                    children: [
                                      const Icon(
                                        Icons.share,
                                        color: AppColors.primarycolor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      AppText(
                                        text: "live",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        textcolor: Colors.green,
                                      ),
                                    ],
                                  )
                                : AppText(
                                    text: "Draft",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textcolor: Colors.grey,
                                  ),
                          ],
                        )
                      : AppText(
                          text: eventName,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                  AppText(
                    text: "$startDate - $endDate",
                    fontWeight: FontWeight.w600,
                    textcolor: AppColors.headTextColor,
                  ),
                  AppPadding.heightSpace5,
                  Row(
                    children: [
                      SvgPicture.string(
                        SvgIcons.mapMarker,
                        width: 15,
                        color: AppColors.headTextColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: AppText(
                          text: location,
                          fontWeight: FontWeight.w600,
                          textcolor: AppColors.headTextColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  ratingBar ?? const SizedBox(),
                  AppPadding.heightSpace15,
                  bottomButton ??
                      Row(
                        mainAxisAlignment: isLive
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.end,
                        children: [
                          RoundButton(
                            onTap: onEdit,
                            text: "Edit",
                          ),
                          isLive
                              ? RoundButton(
                                  onTap: onCancel,
                                  text: "Cancel",
                                )
                              : const SizedBox(
                                  width: 15,
                                ),
                          RoundButton(
                            onTap: onDelete,
                            text: "Delete",
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
