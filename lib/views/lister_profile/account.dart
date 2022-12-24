import 'package:flutter/material.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/views/lister_profile/profile.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_text.dart';

class Account extends StatelessWidget {
  const Account({super.key});

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
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xff302A4E),
          ),
        ),
        title: AppText(
          text: "Account",
          fontWeight: FontWeight.w600,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: Container(
        padding: AppPadding.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.height * 0.10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.everydayhealth.com/images/mens-health/6-skincare-tips-men-should-always-follow-peter-kraus-00-722x406.jpg"))),
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
                            builder: ((context) => const Profile()),
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
              onTap: () {},
              leading: AppText(
                text: "Personal Information",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
              ),
            ),
            SizedBox(
              height: 4,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: AppText(
                text: "My Bookings",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
              ),
            ),
            SizedBox(
              height: 4,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: AppText(
                text: "Payments",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
              ),
            ),
            SizedBox(
              height: 4,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: AppText(
                text: "Notification",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
              ),
            ),
            SizedBox(
              height: 4,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: AppText(
                text: "Terms  &  Conditions",
                fontWeight: FontWeight.w400,
                fontSize: 18,
                textcolor: const Color(0xff232332),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
