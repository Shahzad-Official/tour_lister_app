import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/controllers/main_page_controller/main_page_controller.dart';
import 'package:tour_lister_app/widgets/app_bottom_sheet.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../widgets/app_text.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primarycolor,
      child: SafeArea(
        child: GetBuilder<MainPageController>(
          init: MainPageController(),
          initState: (_) {},
          builder: (_) {
            return Scaffold(
              backgroundColor: AppColors.backgroundcolor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  elevation: 0.0,
                  backgroundColor: AppColors.backgroundcolor,
                  centerTitle: _.currentIndex == 0 ? true : false,
                  title: AppText(
                    text: _.mainScreensTitle[_.currentIndex],
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                    textcolor: Colors.black,
                  ),
                  actions: [
                    _.currentIndex == 0 || _.currentIndex == 3
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: AppCircularCachedImage(
                              picUrl: DummyData.profilePic,
                            ),
                          ),
                  ],
                ),
              ),
              body: Padding(
                padding: AppPadding.defaultPadding,
                child: _.mainScreens[_.currentIndex],
              ),
              bottomNavigationBar: AppBottomSheet(
                onIndexChanged: (index) => _.changeScreen(index),
                currentIndex: _.currentIndex,
              ),
            );
          },
        ),
      ),
    );
  }
}
