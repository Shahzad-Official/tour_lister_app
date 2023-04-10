import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/models/booking_model.dart';
import 'package:tour_lister_app/services/get_user_data.dart';
import 'package:tour_lister_app/views/users_in_package/user_details.dart';
import 'package:tour_lister_app/widgets/app_tile.dart';

import '../../constants/dummy_data.dart';
import '../../constants/svg_icons.dart';
import '../../widgets/app_cached_image.dart';
import '../../widgets/app_text.dart';

class UsersInPackage extends StatefulWidget {
  final BookingModel bookingDetails;
  const UsersInPackage({
    Key? key,
    required this.bookingDetails,
  }) : super(key: key);

  @override
  State<UsersInPackage> createState() => _UsersInPackageState();
}

class _UsersInPackageState extends State<UsersInPackage> {
  GetUserData userData = GetUserData();
  bool isLoading = false;
  getUserData() async {
    setState(() {
      isLoading = true;
    });
    await userData.getUserData(
      widget.bookingDetails.userId!,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

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
                text: "Package : ${widget.bookingDetails.eventName}",
                fontWeight: FontWeight.w600,
                fontSize: 23,
                textcolor: Colors.black,
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
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
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return AppTile(
                              picUrl: userData.userProfile.profile!,
                              onView: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDetails(
                                      userData: userData.userProfile,
                                    ),
                                  ),
                                );
                              },
                              titleText: userData.userProfile.userName!,
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
