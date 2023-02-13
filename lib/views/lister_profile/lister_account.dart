import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/profile_controllers/account_settings_controller.dart';
import 'package:tour_lister_app/models/lister_profile/profile_model.dart';
import 'package:tour_lister_app/services/get_user_data.dart';
import 'package:tour_lister_app/views/lister_profile/lister_profile.dart';
import 'package:tour_lister_app/views/settings_screens/notification_page.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../widgets/app_text.dart';

class ListerAccount extends StatelessWidget {
  bool? isVerified;
  ListerAccount({
    super.key,
    this.isVerified,
  });
  final GetUserData _userData = GetUserData();

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

    return FutureBuilder<ProfileModel>(
        future: _userData.getUserData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            isVerified = snapshot.data!.isVerified;
          } else {
            isVerified = false;
          }
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
                                snapshot.hasData
                                    ? AppCircularCachedImage(
                                        picUrl: snapshot.data!.profile!,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primarycolor,
                                        ),
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
                              snapshot.hasData
                                  ? AppText(
                                      text: snapshot.data!.userName!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      textcolor: const Color(0xff232332),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primarycolor,
                                      ),
                                    ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => ListerProfile(
                                            isVerified:
                                                snapshot.data!.isVerified,
                                            name: snapshot.data!.userName,
                                            dOB: snapshot.data!.dob,
                                            email: snapshot.data!.email,
                                            phoneNo: snapshot.data!.phoneNo,
                                            profileUrl: snapshot.data!.profile!,
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
                                  isVerified: snapshot.data!.isVerified,
                                  name: snapshot.data!.userName,
                                  dOB: snapshot.data!.dob,
                                  email: snapshot.data!.email,
                                  phoneNo: snapshot.data!.phoneNo,
                                  profileUrl: snapshot.data!.profile!,
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
                        onTap: () async {
                          await _userData.getUserData(
                              FirebaseAuth.instance.currentUser!.uid);
                        },
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
                      controller.isLoading
                          ? const SpinKitThreeBounce(
                              color: AppColors.primarycolor,
                              size: 15,
                            )
                          : const SizedBox(),
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
        });
  }
}
