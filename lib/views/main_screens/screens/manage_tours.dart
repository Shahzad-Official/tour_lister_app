import 'package:flutter/material.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/widgets/containers/single_tour_container.dart';

class ManageTours extends StatelessWidget {
  const ManageTours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
    );
  }
}
