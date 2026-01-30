import 'package:flutter/material.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, required this.ontap, required this.text, this.color, this.textColor});
final Function() ontap;
final String text;
final Color? color;
final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 60,
        child: Center(
          child: CustomText(
            text: text ,
            size: 18,
            weight: FontWeight.bold,
            color:textColor ?? AppColor.primaryColor,
          ),
        ),
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(16),
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
