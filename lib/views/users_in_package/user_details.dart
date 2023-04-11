import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_lister_app/models/booking_model.dart';
import 'package:tour_lister_app/models/lister_profile/profile_model.dart';
import 'package:tour_lister_app/utils/app_navigation.dart';
import 'package:tour_lister_app/views/chat_views/chat_screen.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/dummy_data.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_cached_image.dart';
import '../../widgets/app_text.dart';

class UserDetails extends StatelessWidget {
  final ProfileModel userData;
  final BookingModel bookindData;
  const UserDetails({
    Key? key,
    required this.userData,
    required this.bookindData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.backgroundcolor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: SvgPicture.string(
              SvgIcons.backArrow,
            ),
          ),
        ),
        title: AppText(
          text: "User Detail",
          fontWeight: FontWeight.w600,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: AppPadding.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: userData.userName ?? "Pawan",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        textcolor: const Color(0xff232332),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  AppCircularCachedImage(
                    picUrl: userData.profile ?? DummyData.profilePic,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              AppText(
                text: "Email",
                textcolor: AppColors.headTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              AppText(
                text: userData.email ?? DummyData.usersData['email'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace20,
              AppText(
                text: "Phone Number",
                textcolor: AppColors.headTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              AppText(
                text: userData.phoneNo ?? DummyData.usersData['phoneNo'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace20,
              AppText(
                text: "Date of Birth",
                textcolor: AppColors.headTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              AppText(
                text: userData.dob ?? DummyData.usersData['DOB'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace10,
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 160,
        child: FloatingActionButton(
          backgroundColor: AppColors.primarycolor,
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            Navigate.to(
              context,
              ChatScreen(
                bookingId: bookindData.bookingId!,
                receiverId: userData.uid!,
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.string(
                SvgIcons.chat,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              AppText(
                text: "Chat Now",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textcolor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
