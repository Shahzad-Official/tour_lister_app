import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/views/users_in_tour/user_details.dart';
import 'package:tour_lister_app/widgets/app_tile.dart';

import '../../constants/dummy_data.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_cached_image.dart';
import '../../widgets/app_text.dart';

class UsersInTour extends StatelessWidget {
  String tourName;
  UsersInTour({
    Key? key,
    this.tourName = "Sight visit",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.backgroundcolor,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.backgroundcolor,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                  child: SvgPicture.string(
                    SvgIcons.backArrow,
                  ),
                ),
              ),
              title: AppText(
                text: "Tour : $tourName",
                fontWeight: FontWeight.w600,
                fontSize: 23,
                textcolor: Colors.black,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AppCircularCachedImage(
                    picUrl: DummyData.profilePic,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: AppPadding.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "User Booked",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  AppPadding.heightSpace10,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return AppTile(
                        onView: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetails(
                                  name: "Ahmad Ali",
                                ),
                              ));
                        },
                        titleText: "Ahmad Ali",
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
