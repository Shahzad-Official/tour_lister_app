import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/profile_controllers/edit_profile_controller.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_text.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final String profile;
  final String email, phoneNo, dOB, name;
  final bool? isVerified;
  const EditProfile({
    super.key,
    required this.profile,
    required this.phoneNo,
    required this.dOB,
    required this.email,
    this.isVerified,
    required this.name,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final EditProfileController _editprofileController =
      Get.put(EditProfileController());
  @override
  void initState() {
    super.initState();
    _editprofileController.name.text = widget.name;
    _editprofileController.email.text = widget.email;

    _editprofileController.date.text = widget.dOB;
  }

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
          child: GetBuilder<EditProfileController>(
            init: EditProfileController(),
            builder: (profileController) {
              return Column(
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
                                return AppCircularCachedImage(
                                  picRadius: 60,
                                  picUrl: widget.profile,
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
                                    onTap: () {
                                      profileController.getimage(
                                        ImageSource.camera,
                                      );
                                    },
                                    child: Text(
                                      "Camera",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff8E89A9),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      profileController.getimage(
                                        ImageSource.gallery,
                                      );
                                    },
                                    child: Text(
                                      "Choose from gallery",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff8E89A9),
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AppInputField(
                    hintText: widget.name.toString(),
                    controller: profileController.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppInputField(
                    hintText: widget.email.toString(),
                    controller: profileController.email,
                    keyboardtype: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PhoneField(
                    controller: profileController.phone,
                    countryCode: profileController.countryCode,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<EditProfileController>(
                    init: EditProfileController(),
                    initState: (_) {},
                    builder: (_) {
                      return AppInputField(
                        controller: _.date,
                        enabled: false,
                        onTap: () async {
                          await _.selectDate(context);
                        },
                        hintText: widget.dOB.toString(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  AppButton(
                    isLoading: profileController.isLoading,
                    btnText: "Save",
                    ontap: () async {
                      await profileController.isValidUser();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
