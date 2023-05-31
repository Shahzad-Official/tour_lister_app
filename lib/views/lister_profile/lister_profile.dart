import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import 'edit_profile.dart';

class ListerProfile extends StatelessWidget {
  final String profileUrl;
  final String? email, phoneNo, dOB, name;
  final bool? isVerified;
  const ListerProfile({
    super.key,
    required this.profileUrl,
    this.phoneNo,
    this.dOB,
    this.email,
    this.isVerified,
    this.name,
  });

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
          text: "Profile",
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        text: "Hi! $name",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        textcolor: const Color(0xff232332),
                      ),
                      AppText(
                        text: "Joined - Mar 2021",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        textcolor: const Color(0xff8E89A9),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: [
                        AppCircularCachedImage(
                          picUrl: profileUrl,
                        ),
                        isVerified ?? true
                            ? Align(
                                alignment: Alignment.bottomRight,
                                child: ColoredBox(
                                  color: Colors.white,
                                  child: SvgPicture.string(
                                    SvgIcons.verified,
                                    width: 20,
                                    // ignore: deprecated_member_use
                                    color: AppColors.primarycolor,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
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
                text: email ?? DummyData.profileData['email'],
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
                text: phoneNo ?? DummyData.profileData['phoneNo'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace20,
              AppText(
                text: "Date of Joining",
                textcolor: AppColors.headTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              AppText(
                text: dOB ?? DummyData.profileData['DOB'],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              AppPadding.heightSpace10,
              const Divider(),
              AppPadding.heightSpace20,
              const SizedBox(
                height: 100,
              ),
              AppButton(
                btnText: "Edit",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => EditProfile(
                            profile: profileUrl,
                            dOB: dOB!,
                            email: email!,
                            isVerified: isVerified,
                            name: name!,
                            phoneNo: phoneNo!,
                          )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
