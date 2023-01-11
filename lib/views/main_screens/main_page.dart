import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';

import 'package:tour_lister_app/controllers/main_page_controller/main_page_controller.dart';
import 'package:tour_lister_app/widgets/app_bottom_sheet.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../widgets/app_text.dart';

class MainPage extends StatelessWidget {
  int currentIndex;
  MainPageController mainPageController = Get.put(MainPageController());
  MainPage({
    Key? key,
    this.currentIndex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mainPageController.currentIndex = currentIndex;
    return ColoredBox(
      color: AppColors.primarycolor,
      child: SafeArea(
        child: GetBuilder<MainPageController>(
          init: MainPageController(),
          initState: (_) {},
          builder: (_) {
            return Scaffold(
              backgroundColor: AppColors.backgroundcolor,
              appBar: _.currentIndex == 0 ||
                      _.currentIndex == 1 ||
                      _.currentIndex == 3
                  ? PreferredSize(
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
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("listers")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .get()
                                          .asStream(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return AppCircularCachedImage(
                                            picUrl: snapshot.data!
                                                .data()!['profile'],
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primarycolor,
                                            ),
                                          );
                                        }
                                      }),
                                ),
                        ],
                      ),
                    )
                  : null,
              body: _.mainScreens[_.currentIndex],
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
