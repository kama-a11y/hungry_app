import 'package:flutter/material.dart';
import 'package:hungryapp/core/constants/app_color.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.controller, required this.labelName, this.textInputType, required this.color});
final TextEditingController controller ;
final String labelName;
final TextInputType? textInputType;
final Color color;
  @override
  Widget build(BuildContext context) {
    return TextField(

              controller: controller,
              cursorColor: color,
              style: TextStyle(color: color,fontSize: 18),
              keyboardType:textInputType,
              decoration: InputDecoration(
                labelText: labelName,
                labelStyle: TextStyle(color: color,fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
        
                enabledBorder:OutlineInputBorder(
                 borderSide: BorderSide(
                  color: color
                 ),
                 borderRadius: BorderRadius.circular(16) 
                ),
                focusedBorder:OutlineInputBorder(
                 borderSide: BorderSide(
                  color: color
                 ),
                 borderRadius: BorderRadius.circular(16) 
                ), 
              ),
            );
  }
}