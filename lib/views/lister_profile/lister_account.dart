import 'package:flutter/material.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/views/lister_profile/lister_profile.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../widgets/app_text.dart';

class ListerAccount extends StatelessWidget {
  const ListerAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AppCircularCachedImage(
                picUrl: DummyData.profilePic,
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
            onTap: () {},
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
            onTap: () {},
            leading: AppText(
              text: "My Bookings",
              fontWeight: FontWeight.w400,
              fontSize: 18,
              textcolor: const Color(0xff232332),
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () {},
            leading: AppText(
              text: "Notification",
              fontWeight: FontWeight.w400,
              fontSize: 18,
              textcolor: const Color(0xff232332),
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
            onTap: () {},
            leading: AppText(
              text: "Upload certificates",
              fontWeight: FontWeight.w400,
              fontSize: 18,
              textcolor: const Color(0xff232332),
            ),
          ),
        ],
      ),
    );
  }
}
