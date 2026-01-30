import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/feature/auth/widgets/profile_field.dart';
import 'package:hungryapp/shared/custom_text.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
   ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
TextEditingController _Name =TextEditingController();

TextEditingController _Email =TextEditingController();

TextEditingController _Address =TextEditingController();

@override
  void initState() {
    _Name.text = 'Kamal Taha';
    _Email.text = 'kamaltaha298@gmail.com';
    _Address.text = 'Nefia-Tanta-Elgarbia';

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leading: Icon(Icons.arrow_back,color: Colors.white,size: 28,),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
            child: Icon(Icons.settings,color: Colors.white,size: 28,),
          )
        ],  
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
              radius: 82,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/checkout/profile.png'),
                radius: 80),
            ),
                  
                   ),
                  Gap(30),
                  ProfileField(controller: _Name, labelName: 'Name'),
                  Gap(25),
                  ProfileField(controller: _Email, labelName: 'Email'),
                  Gap(25),
                  ProfileField(controller: _Address, labelName: 'Address'),
                  Gap(25),
                  Divider(),
                  Gap(25),
                  ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 13),
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16)
                      ),
                      leading:Image.asset('assets/checkout/visa.png',width: 70,) ,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Debit card', size: 16,weight: FontWeight.bold,),
                          CustomText(text: '3566 **** **** 0505', size: 16,color: Colors.grey.shade600),
                        ],
                      ),
                      tileColor:Color(0xffF3F4F6) ,
                      trailing:  CustomText(text: 'Default', size: 16,),
                    ),
            
                    
                  
              ],
            ),
          ),
        ),
      ),

       bottomSheet: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
            GestureDetector(
                onTap:(){},
                child: Container(
                  width: 180,
                  height: 60,
                  child: Center(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: 'Edit Profile',
                            size: 18,
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          Gap(5),
                          Icon(CupertinoIcons.pencil,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
              Spacer(),
            
              GestureDetector(
                onTap:(){},
                child: Container(
                  width: 180,
                  height: 60,
                  child: Center(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: 'Logout',
                            size: 18,
                            weight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                          Gap(5),
                          Icon(Icons.logout,color: AppColor.primaryColor,size: 24,)
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.primaryColor,
                      width: 2   
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
