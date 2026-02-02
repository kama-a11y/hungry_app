import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/feature/auth/data/auth_repo.dart';
import 'package:hungryapp/feature/auth/view/signup_view.dart';
import 'package:hungryapp/feature/auth/widgets/custom_auth_button.dart';
import 'package:hungryapp/feature/root.dart';
import 'package:hungryapp/shared/custom_text.dart';
import 'package:hungryapp/shared/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();
  bool isLoading = false;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final user = await authRepo.login(  
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
        ///debug
        //  debugPrint(e.runtimeType.toString());
        //  debugPrint(e.toString());
         
          
        setState(() {
          isLoading = false;
        });
        String errorMsg = "some thing went wrong";
        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Spacer(),
                  SvgPicture.asset(
                    'assets/logo/Hungry_.svg',
                    color: AppColor.primaryColor,
                    width: 294,
                  ),
                  Gap(10),
                  CustomText(
                    text: "Welcome Back, Discover The Fast Food",
                    weight: FontWeight.bold,
                    size: 16,
                    color: Colors.grey.shade700,
                  ),
                  Gap(90),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 60,
                      bottom: 150,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          hint: 'Email Adress',
                          isPassword: false,
                        ),
                        Gap(20),
                        CustomTextField(
                          controller: passwordController,
                          hint: 'Password',
                          isPassword: true,
                        ),

                        Gap(30),

                        isLoading
                            ? CupertinoActivityIndicator(color: Colors.white)
                            : CustomAuthButton(
                                ontap: login,
                                text: 'Login',
                                textColor: Colors.white,
                                color: AppColor.primaryColor,
                              ),
                        Gap(20),
                        CustomAuthButton(
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (c) => SignupView()),
                            );
                          },
                          text: 'Create Account ?',
                        ),
                        Gap(20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => Root()),
                              (route) => false,
                            );
                          },
                          child: CustomText(
                            text: 'Continue as a guest ?',
                            size: 14,
                            weight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
