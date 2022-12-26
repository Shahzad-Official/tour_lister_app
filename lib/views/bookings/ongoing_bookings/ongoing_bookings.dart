import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/rating_bar/tour_rating_bar.dart';

import '../../../constants/app_paddings.dart';
import '../../../constants/svg_icons.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/containers/single_tour_container.dart';

class OngoingBookings extends StatelessWidget {
  const OngoingBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPadding.heightSpace30,
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
                  ratingBar: const TourRatingBar(),
                  bottomButton: Align(
                    alignment: Alignment.bottomRight,
                    child: RoundButton(
                      text: "view",
                    ),
                  ),
                  startDate: "12 Mar",
                  endDate: "2 May",
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
