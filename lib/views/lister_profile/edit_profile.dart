import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/profile_controllers/edit_profile_controller.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_text.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final EditProfileController _profileController =
      Get.put(EditProfileController());

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
          text: "Edit Profile",
          fontWeight: FontWeight.w600,
          fontSize: 23,
          textcolor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: AppPadding.defaultPadding,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 125,
                width: 125,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: GetBuilder<EditProfileController>(
                        init: EditProfileController(),
                        initState: (_) {},
                        builder: (_) {
                          if (_.image != null) {
                            return CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(
                                _.image!,
                              ),
                            );
                          } else {
                            return AppCachedImage(
                              picRadius: 60,
                              picUrl: DummyData.profilePic,
                            );
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.10,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(86, 0, 0, 0),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: Offset(2, 0),
                            ),
                          ],
                        ),
                        child: PopupMenuButton(
                          position: PopupMenuPosition.under,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    _profileController.getimage(
                                      ImageSource.gallery,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Choose from gallery",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff8E89A9),
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    _profileController.getimage(
                                      ImageSource.camera,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Camera",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff8E89A9),
                                    ),
                                  ),
                                ),
                              ),
                            ];
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.string(SvgIcons.pencil),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              AppInputField(
                hintText: "Pawan Kumar",
                controller: _profileController.name,
              ),
              const SizedBox(
                height: 20,
              ),
              AppInputField(
                hintText: "abc@gmail.com",
                controller: _profileController.email,
                keyboardtype: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              AppInputField(
                hintText: "+971455656",
                controller: _profileController.phone,
                keyboardtype: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<EditProfileController>(
                init: EditProfileController(),
                initState: (_) {},
                builder: (_) {
                  return AppInputField(
                    enabled: false,
                    onTap: () async {
                      await _.selectDate(context);
                    },
                    hintText: _.date ?? _.currentDate(),
                  );
                },
              ),
              const SizedBox(
                height: 70,
              ),
              AppButton(
                btnText: "Save",
                ontap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
