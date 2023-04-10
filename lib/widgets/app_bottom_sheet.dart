import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/widgets/app_text.dart';

// ignore: must_be_immutable
class AppBottomSheet extends StatelessWidget {
  int currentIndex;
  void Function(int index)? onIndexChanged;
  AppBottomSheet({
    Key? key,
    this.currentIndex = 0,
    this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onIndexChanged,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  SvgIcons.mapMarker,
                  width: 30,
                  color: currentIndex == 0
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
                AppText(
                  text: "Create Package",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textcolor: currentIndex == 0
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  SvgIcons.plane,
                  width: 27,
                  color: currentIndex == 1
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
                AppText(
                  text: "Manage Packages",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textcolor: currentIndex == 1
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  SvgIcons.calender,
                  width: 25,
                  color: currentIndex == 2
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
                AppText(
                  text: "Manage Bookings",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textcolor: currentIndex == 2
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.string(
                  SvgIcons.profile,
                  width: 22,
                  color: currentIndex == 3
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
                AppText(
                  text: "Profile",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textcolor: currentIndex == 3
                      ? AppColors.primarycolor
                      : AppColors.headTextColor,
                ),
              ],
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
