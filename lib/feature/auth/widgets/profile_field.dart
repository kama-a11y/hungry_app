import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.controller, required this.labelName});
final TextEditingController controller ;
final String labelName;
  @override
  Widget build(BuildContext context) {
    return TextField(

              controller: controller,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white,fontSize: 18),
              decoration: InputDecoration(
                labelText: labelName,
                labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
        
                enabledBorder:OutlineInputBorder(
                 borderSide: BorderSide(
                  color: Colors.white
                 ),
                 borderRadius: BorderRadius.circular(16) 
                ),
                focusedBorder:OutlineInputBorder(
                 borderSide: BorderSide(
                  color: Colors.white
                 ),
                 borderRadius: BorderRadius.circular(16) 
                ), 
              ),
            );
  }
}