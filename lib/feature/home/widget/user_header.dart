import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/feature/auth/data/auth_repo.dart';
import 'package:hungryapp/feature/auth/data/user_model.dart';
import 'package:hungryapp/shared/custom_snack_bar.dart';
import 'package:hungryapp/shared/custom_text.dart';

class UserHeader extends StatefulWidget {
    UserHeader({super.key});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
 UserModel? userModel;

  String? selectedImage;

  AuthRepo authRepo = AuthRepo();

   /// get profile
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      if (!mounted) return;
      setState(() {
        userModel = user;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg));
    }
  }
@override
  void initState() {
    getProfileData();
    // TODO: implement initState
    super.initState();
  }
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
            backgroundImage: selectedImage != null
                                      ? FileImage(File(selectedImage!))
                                      : (userModel?.image != null &&
                                            userModel!.image!.isNotEmpty)
                                      ? NetworkImage(userModel!.image!)
                                      : const AssetImage(
                                              'assets/checkout/person.png',
                                            )
                                            as ImageProvider,
            radius: 35),
        ),
      ],
    );
  }
}
