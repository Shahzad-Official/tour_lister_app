import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/widgets/app_button.dart';

import '../../constants/svg_icons.dart';
import '../../widgets/app_text.dart';

// ignore: must_be_immutable
class NotificationPage extends StatefulWidget {
  List<bool>? isRead;
  NotificationPage({
    Key? key,
    this.isRead,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
              text: "Notifications List",
              fontWeight: FontWeight.w600,
              fontSize: 23,
              textcolor: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: AppPadding.defaultPadding,
              child: Column(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      tileColor: widget.isRead![index]
                          ? Colors.transparent
                          : AppColors.primarycolor.withOpacity(0.2),
                      onTap: () {
                        widget.isRead![index] = true;
                        setState(() {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationDetails(
                              title: "Notification 1",
                              details: "Hello this is notification 1 detail.",
                            ),
                          ),
                        );
                      },
                      leading: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.notifications_none_outlined,
                        ),
                      ),
                      title: AppText(
                        text: "notificationTitle",
                      ),
                      subtitle: AppText(text: "description"),
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
                  ontap: (() => Navigator.pop(context)),
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
