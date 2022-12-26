import 'package:flutter/material.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/views/users_in_tour/user_details.dart';
import 'package:tour_lister_app/widgets/app_tile.dart';

import '../../constants/dummy_data.dart';
import '../../widgets/app_cached_image.dart';
import '../../widgets/app_text.dart';

class UsersInTour extends StatelessWidget {
  const UsersInTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "User Booked",
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        AppPadding.heightSpace10,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, index) {
            return AppTile(
              onView: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetails(
                        name: "Ahmad Ali",
                      ),
                    ));
              },
              titleText: "Ahmad Ali",
            );
          },
        ),
      ],
    );
  }
}
