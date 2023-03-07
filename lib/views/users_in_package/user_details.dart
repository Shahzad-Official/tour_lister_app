import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/utils/app_navigation.dart';
import 'package:tour_lister_app/views/chat_views/chat_screen.dart';
import 'package:tour_lister_app/widgets/app_button.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/dummy_data.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_cached_image.dart';
import '../../widgets/app_text.dart';

class UserDetails extends StatelessWidget {
  String? profileUrl, email, phoneNo, gender, dOB, name;
  UserDetails({
    Key? key,
    this.dOB,
    this.email,
    this.gender,
    this.phoneNo,
    this.profileUrl,
    this.name,
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
                        text: name ?? "Pawan",
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
                    picUrl: profileUrl ?? DummyData.profilePic,
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
                text: email ?? DummyData.usersData['email'],
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
                text: phoneNo ?? DummyData.usersData['phoneNo'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace20,
              AppText(
                text: "Gender",
                textcolor: AppColors.headTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              AppText(
                text: gender ?? DummyData.usersData['gender'],
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
                text: dOB ?? DummyData.usersData['DOB'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace10,
              RoundButton(
                onTap: () {
                  Navigate.to(
                    context,
                    const ChatScreen(),
                  );
                },
                fontSize: 25,
                text: "Chat",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
