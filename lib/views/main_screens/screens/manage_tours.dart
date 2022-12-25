import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';
import 'package:tour_lister_app/widgets/containers/single_tour_container.dart';

class ManageTours extends StatelessWidget {
  const ManageTours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.defaultPadding,
        child: Column(
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
                      isLive: index == 0 ? true : false,
                      startDate: "12 Mar",
                      endDate: "2 May",
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
