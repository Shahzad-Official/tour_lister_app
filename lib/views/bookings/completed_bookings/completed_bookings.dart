import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../../constants/app_paddings.dart';
import '../../../constants/svg_icons.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/containers/single_tour_container.dart';

class CompletedBookings extends StatelessWidget {
  const CompletedBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppInputField(
          hintText: "search for tours",
          contentPadding: const EdgeInsets.only(top: 20),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: SvgPicture.string(
              SvgIcons.search,
            ),
          ),
        ),
        Column(
          children: List.generate(10, (index) {
            return Column(
              children: [
                AppPadding.heightSpace30,
                SingleTourContainer(
                  bottomButton: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundButton(
                        text: "Duplicate",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RoundButton(
                        text: "Relist Tour",
                      ),
                    ],
                  ),
                  startDate: "12 Mar",
                  endDate: "2 May",
                ),
              ],
            );
          }),
        ),
        AppPadding.heightSpace20,
      ],
    );
  }
}
