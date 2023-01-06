import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/profile_controllers/account_settings_controller.dart';
import 'package:tour_lister_app/views/lister_profile/lister_profile.dart';
import 'package:tour_lister_app/views/settings_screens/notification_page.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../widgets/app_text.dart';

class ListerAccount extends StatelessWidget {
  String? profileUrl;
  bool? isVerified;
  ListerAccount({
    super.key,
    this.profileUrl,
    this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    List<bool> isRead = List.generate(
      10,
      (index) {
        if (index.isEven) {
          return false;
        } else {
          return true;
        }
      },
    );
    var newlist = isRead.where(
      (element) => element == false,
    );

    return Container(
      padding: AppPadding.defaultPadding,
      child: GetBuilder<AccountSettingsController>(
          init: AccountSettingsController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: [
                          AppCircularCachedImage(
                            picUrl: profileUrl ?? DummyData.profilePic,
                          ),
                          isVerified ?? true
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: ColoredBox(
                                    color: Colors.white,
                                    child: SvgPicture.string(
                                      SvgIcons.verified,
                                      width: 20,
                                      color: AppColors.primarycolor,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Pawan Kumar",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          textcolor: const Color(0xff232332),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const ListerProfile(
                                      profileUrl: DummyData.profilePic,
                                    )),
                              ),
                            );
                          },
                          child: AppText(
                            text: "View my profile",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            textcolor: const Color(0xff39ACFF),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                AppText(
                  text: "Settings",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  textcolor: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListerProfile(
                            profileUrl: profileUrl ?? DummyData.profilePic,
                          ),
                        ));
                  },
                  leading: AppText(
                    text: "Personal Information",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    textcolor: const Color(0xff232332),
                  ),
                ),
                // const Divider(),
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   onTap: () {},
                //   leading: AppText(
                //     text: "My Bookings",
                //     fontWeight: FontWeight.w400,
                //     fontSize: 18,
                //     textcolor: const Color(0xff232332),
                //   ),
                // ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationPage(
                            isRead: isRead,
                          ),
                        ));
                  },
                  leading: AppText(
                    text: "Notification",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    textcolor: const Color(0xff232332),
                  ),
                  trailing: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primarycolor,
                    ),
                    child: Center(
                      child: AppText(
                        text: newlist.length.toString(),
                        fontSize: 10,
                        textcolor: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {},
                  leading: AppText(
                    text: "Link Stripe Account",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    textcolor: const Color(0xff232332),
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    controller.uploadCertificate();
                  },
                  leading: AppText(
                    text: "Upload certificates",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    textcolor: const Color(0xff232332),
                  ),
                ),
                controller.fileName != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Center(
                          child: AppText(
                            text: controller.fileName!,
                            textcolor: AppColors.primarycolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          }),
    );
  }
}
