import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/services/booking_services/get_all_bookings.dart';
import 'package:tour_lister_app/services/get_user_data.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';
import 'package:tour_lister_app/widgets/app_button.dart';

import '../../constants/svg_icons.dart';
import '../../widgets/app_text.dart';

// ignore: must_be_immutable
class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GetUserData _getUserData = GetUserData();
  final GetAllBookings _getAllBookings = GetAllBookings();
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    await _getAllBookings.getNotifications();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primarycolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.backgroundcolor,
            leading: InkWell(
              onTap: (() => Get.offAll(
                    () => MainPage(
                      currentIndex: 3,
                    ),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: SvgPicture.string(
                  SvgIcons.backArrow,
                ),
              ),
            ),
            title: AppText(
              text: "Notifications List",
              fontWeight: FontWeight.w600,
              fontSize: 23,
              textcolor: Colors.black,
            ),
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: AppPadding.defaultPadding,
                    child: Column(
                      children: List.generate(
                          _getAllBookings.allNotifications.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: _getAllBookings
                                          .allNotifications[index].status ==
                                      "seen"
                                  ? Colors.transparent
                                  : AppColors.primarycolor.withOpacity(0.2),
                            ),
                            child: FutureBuilder(
                              future: _getUserData.getUserData(_getAllBookings
                                  .allNotifications[index].userId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return InkWell(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationDetails(
                                            title: _getAllBookings
                                                .allNotifications[index].message
                                                .toString(),
                                            details:
                                                "${snapshot.data!.userName!} ${_getAllBookings.allNotifications[index].message.toString()}",
                                          ),
                                        ),
                                      );
                                      await _getAllBookings.seenNotification(
                                        _getAllBookings
                                            .allNotifications[index].id!,
                                      );
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Icon(
                                            Icons.notifications_none_outlined,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text: _getAllBookings
                                                  .allNotifications[index]
                                                  .message
                                                  .toString(),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: AppText(
                                      text: "Loading...",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NotificationDetails extends StatelessWidget {
  String title, details;
  NotificationDetails({
    Key? key,
    required this.details,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primarycolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.backgroundcolor,
            leading: InkWell(
              onTap: () {
                Get.offAll(
                  () => const NotificationPage(),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: SvgPicture.string(
                  SvgIcons.backArrow,
                ),
              ),
            ),
            title: AppText(
              text: "Notification Details",
              fontWeight: FontWeight.w600,
              fontSize: 23,
              textcolor: Colors.black,
            ),
          ),
          body: Padding(
            padding: AppPadding.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: title,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                AppPadding.heightSpace30,
                AppText(
                  text: details,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                AppButton(
                  btnText: "OK",
                  ontap: (() => Get.offAll(
                        () => MainPage(
                          currentIndex: 3,
                        ),
                      )),
                ),
                AppPadding.heightSpace30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
