import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';
import 'package:hungryapp/feature/auth/data/auth_repo.dart';
import 'package:hungryapp/feature/auth/data/user_model.dart';
import 'package:hungryapp/feature/auth/view/login_view.dart';
import 'package:hungryapp/feature/auth/widgets/profile_field.dart';
import 'package:hungryapp/feature/root.dart';
import 'package:hungryapp/shared/custom_snack_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../shared/custom_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  bool isGuest = false;

  UserModel? userModel;
  String? selectedImage;
  bool isLoadingUpdate = false;
  bool isLoadingLogout = false;
  AuthRepo authRepo = AuthRepo();

  // Future<void> autoLogin() async {
  //   final user = await authRepo.autoLogin();
  //   setState(() => isGuest = authRepo.isGuest);
  //   if (user != null) setState(() => userModel = user);
  // }

  /// get profile
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg));
    }
  }

  /// update profile
  Future<void> updateProfileData() async {
    try {
      setState(() => isLoadingUpdate = true);
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        imagePath: selectedImage,
        visa: _visa.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(CustomSnackBar('Profile updated Successfully'));
      setState(() => isLoadingUpdate = false);
      setState(() => userModel = user);
      await getProfileData();
    } catch (e) {
      setState(() => isLoadingUpdate = false);
      String errorMsg = 'Failed to update profile';
      if (e is ApiError) errorMsg = e.message;
      print(errorMsg);
    }
  }

  /// pick image
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    getProfileData().then((v) {
      _name.text = userModel?.name.toString() ?? 'Knuckles';
      _email.text = userModel?.email.toString() ?? 'Knuckles@gmail.com';
      _address.text =
          userModel?.adress == null ? "55 Dubai, UAE" : userModel!.adress!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return RefreshIndicator(
        displacement: 40,
        color: Colors.white,
        backgroundColor: AppColor.primaryColor,
        onRefresh: () async => await getProfileData(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.0,
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0.0,
            ),

            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Skeletonizer(
                  enabled: userModel == null,
                  containersColor: AppColor.primaryColor.withOpacity(0.3),
                  child: Column(
                    children: [
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (c) => Root()),
                                );
                              },
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColor.primaryColor,
                            ),
                          ),
                         
                        ],
                      ),

                      /// image
                       CircleAvatar(
                              radius: 68,
                              backgroundColor: AppColor.primaryColor,
                              child: CircleAvatar(
                                radius: 66,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 64,
                                  backgroundImage: selectedImage != null
                                      ? FileImage(File(selectedImage!))
                                      : (userModel?.image != null &&
                                            userModel!.image!.isNotEmpty)
                                      ? NetworkImage(userModel!.image!)
                                      : const AssetImage(
                                              'assets/checkout/person.png',
                                            )
                                            as ImageProvider,
                                ),
                              ),
                            ),

                    
                      Gap(10),
                          GestureDetector(
                            onTap: pickImage,
                            child: Card(
                              elevation: 0.0,
                              color: const Color.fromARGB(255, 6, 78, 13),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'Upload',
                                      weight: FontWeight.w500,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    Gap(15),
                                    Icon(
                                      CupertinoIcons.camera,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                      Gap(20),

                      /// Form
                      ProfileField(controller: _name, labelName: 'Name', color: AppColor.primaryColor,),
                      Gap(25),
                      ProfileField(controller: _email, labelName: 'Email', color: AppColor.primaryColor,),
                      Gap(25),
                      ProfileField(
                        controller: _address,
                        labelName: 'Address', color: AppColor.primaryColor,
                      ),
                      Gap(25),
                      Divider(color: AppColor.primaryColor,),
                      Gap(10),
                      userModel?.visa == null
                          ? ProfileField(
                            controller: _visa,
                            textInputType: TextInputType.number,
                            labelName: 'add VISA CARD', color: AppColor.primaryColor,
                          )
                          : Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade900,
                                  Colors.blue.shade900,
                                  Colors.blue.shade500,
                                  Colors.blue.shade900,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/checkout/visa.png',
                                  width: 45,
                                  color: Colors.white,
                                ),
                                Gap(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Debit Card',
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    CustomText(
                                      text:
                                          userModel?.visa ??
                                          "**** **** **** 9857",
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: CustomText(
                                    text: 'Default',
                                    color: Colors.grey.shade800,
                                    size: 12,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                Gap(8),
                                Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                      Gap(10),
                      SizedBox(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Edit
                            Expanded(
                              child: GestureDetector(
                                onTap: updateProfileData,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:
                                      isLoadingUpdate
                                          ? CupertinoActivityIndicator(
                                            color: Colors.white,
                                          )
                                          : Center(
                                            child: CustomText(
                                              text: 'Edit Profile',
                                              weight: FontWeight.w600,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                ),
                              ),
                            ),

                            Gap(10),

                            /// logout
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  PrefHelper.clearToken();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => LoginView(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColor.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: isLoadingLogout
                                      ? CupertinoActivityIndicator(
                                          color: AppColor.primaryColor,
                                        )
                                      : Center(
                                          child: CustomText(
                                            text: 'Logout',
                                            weight: FontWeight.w600,
                                            color: AppColor.primaryColor,
                                            size: 18,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(300),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
}

