

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/feature/auth/data/auth_repo.dart';
import 'package:hungryapp/feature/auth/view/login_view.dart';
import 'package:hungryapp/feature/auth/widgets/custom_auth_button.dart';
import 'package:hungryapp/feature/root.dart';
import 'package:hungryapp/shared/custom_text.dart';
import 'package:hungryapp/shared/custom_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
} 

class _SignupViewState extends State<SignupView> {
  TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController= TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();
  bool isLoading = false;
  
  Future<void> Signup() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final user = await authRepo.Signup(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (c) => Root()));
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        String errorMsg = "some thing went wrong";
        if (e is ApiError) {
          setState(() {
            errorMsg = e.message;
          });
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 20,left: 10,right: 10),
            clipBehavior: Clip.none,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade600,
            content: Row(
              children: [
                Icon(CupertinoIcons.info,color: Colors.white,),
                Gap(10),
                CustomText(text: errorMsg, size: 16,color: Colors.white,)
              ],
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Spacer(),
                  SvgPicture.asset('assets/logo/Hungry_.svg',color: AppColor.primaryColor,width: 294,),
                  Gap(10),
                  CustomText(text:"Welcome to our Food App", weight: FontWeight.bold, size: 16, color: Colors.grey.shade700),
                  Gap(100),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20,right: 20,top:60,bottom: 120),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                   controller: nameController, 
                   hint: 'Name',
                   isPassword: false),
                   
                   Gap(20),
                  CustomTextField(
                   controller: emailController, 
                   hint: 'Email Adress',
                   isPassword: false),

                   Gap(20),

                   CustomTextField(
                   controller: passwordController, 
                   hint: 'Password',
                   isPassword: true),

                   Gap(30),

                   isLoading?
                   CupertinoActivityIndicator(color: Colors.white,)
                   : CustomAuthButton(
                    ontap: Signup,
                     text: 'Sign up',
                     textColor: Colors.white,
                     color: AppColor.primaryColor,
                     
                     ),
                     Gap(20),
                   CustomAuthButton(
                    ontap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginView())); 
                    } ,
                    text: 'Go To Login ?',
                     
                     ),  

                      ],
                    ),
                  )
                                  ],
              ),
            ),
          )),
      ),
    );
  }
}