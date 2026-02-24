
import 'package:flutter/material.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.ontap, required this.width, required this.height, this.color, this.textColor});
  final String text;
  final Function() ontap;
  final double width;
  final double height;
  final Color? textColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ontap,
      child: Container(
                      width: width,
                      height: height,
                      child: Center(child: CustomText(text: text, size: 18,weight: FontWeight.bold,color: textColor ?? Colors.white,)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color:color ?? AppColor.primaryColor,
                      ),
                    ),
    );
  }
}