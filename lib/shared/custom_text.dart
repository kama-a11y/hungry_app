
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.weight, required this.size, this.color});
  final String text;
  final FontWeight? weight;
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(text,
            overflow: TextOverflow.ellipsis ,
             maxLines:3 ,
             textScaler:TextScaler.linear(1.0) ,
            style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: color,

            ),)
;
  }
}