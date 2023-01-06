import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/models/events/events_model.dart';
import 'package:tour_lister_app/views/users_in_package/user_details.dart';
import 'package:tour_lister_app/widgets/app_tile.dart';

import '../../constants/dummy_data.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_cached_image.dart';
import '../../widgets/app_text.dart';

class UsersInPackage extends StatelessWidget {
  String tourName;
  List<Users> users;
  UsersInPackage({
    Key? key,
    this.tourName = "Sight visit",
    required this.users,
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
                text: "Package : $tourName",
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
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return AppTile(
                        picUrl: users[index].pic!,
                        onView: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetails(
                                name: users[index].name,
                                dOB: users[index].dOB,
                                email: users[index].email,
                                gender: users[index].gender,
                                phoneNo: users[index].phoneNo,
                                profileUrl: users[index].pic,
                              ),
                            ),
                          );
                        },
                        titleText: users[index].name!,
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
