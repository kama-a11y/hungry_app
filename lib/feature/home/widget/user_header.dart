import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/logo/Hungry_.svg',
              color: AppColor.primaryColor,
            ),
            Gap(10),
            CustomText(
              text: 'Hello, Hungry Customer',
              size: 16,
              color: Colors.grey.shade700,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 36,
          backgroundColor: AppColor.primaryColor,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/checkout/profile.png'),
            radius: 35),
        ),
      ],
    );
  }
}
