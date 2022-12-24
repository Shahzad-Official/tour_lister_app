import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/main_screens_controllers/create_tour_controller.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';

class CreateTour extends StatelessWidget {
  const CreateTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTourController>(
      init: CreateTourController(),
      builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              AppInputField(
                hintText: "Tour Name",
              ),
              AppPadding.heightSpace30,
              AppInputField(
                hintText: "Location",
                contentPadding: const EdgeInsets.only(
                  top: 20,
                  left: 15,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 17,
                  ),
                  child: SvgPicture.string(
                    SvgIcons.mapMarkerFilled,
                    width: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              AppPadding.heightSpace30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppInputField(
                    onTap: () {
                      _.selectStartDate(context);
                    },
                    width: 160,
                    enabled: false,
                    hintText: _.startDate ?? "Start Date",
                    contentPadding: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 20,
                      ),
                      child: SvgPicture.string(
                        SvgIcons.calendarFilled,
                        width: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  AppInputField(
                    onTap: () {
                      _.selectEndDate(context);
                    },
                    width: 160,
                    enabled: false,
                    hintText: _.endDate ?? "End Date",
                    contentPadding: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20,
                        ),
                        child: SvgPicture.string(
                          SvgIcons.calendarFilled,
                          width: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppPadding.heightSpace30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppInputField(
                    keyboardtype: TextInputType.number,
                    width: 160,
                    hintText: "Start Price",
                  ),
                  AppInputField(
                    keyboardtype: TextInputType.number,
                    width: 160,
                    hintText: "End Price",
                  ),
                ],
              ),
              AppPadding.heightSpace30,
              AppInputField(
                enabled: false,
                onTap: () {
                  _.selectTime(context);
                },
                hintText: _.cuttoffTime.text.isEmpty
                    ? "Cutoff Time"
                    : _.cuttoffTime.text,
                contentPadding: const EdgeInsets.only(
                  top: 20,
                  left: 15,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 17,
                  ),
                  child: SvgPicture.string(
                    SvgIcons.clock,
                    width: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              AppPadding.heightSpace30,
              AppInputField(
                enabled: false,
                onTap: () {
                  _.pickOtherImage();
                },
                hintText: _.otherImageUploadStatus ?? "Upload Other Images",
                contentPadding: const EdgeInsets.only(
                  top: 20,
                  left: 15,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 17,
                  ),
                  child: SvgPicture.string(
                    SvgIcons.cameraFilled,
                    width: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              AppPadding.heightSpace30,
              AppInputField(
                enabled: false,
                onTap: () {
                  _.pickCoverImage();
                },
                hintText: _.coverImageUploadStatus ?? "Upload Cover Image",
                contentPadding: const EdgeInsets.only(
                  top: 20,
                  left: 15,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 17,
                  ),
                  child: SvgPicture.string(
                    SvgIcons.cameraFilled,
                    width: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
