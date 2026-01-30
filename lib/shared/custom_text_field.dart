import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungryapp/core/constants/app_color.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.hint, required this.isPassword, required this.controller});
  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
late bool _obscureText;

@override
void initState() {
  _obscureText = widget.isPassword;
  super.initState();
}
void _togglePassword(){
  setState(() {
    _obscureText = !_obscureText;
  });
}
  @override
  Widget build(BuildContext context) {
    return TextFormField(           
                controller: widget.controller,
                cursorHeight: 20,
                cursorColor: AppColor.primaryColor,
                validator:(v){
                  if( v == null || v.isEmpty){
                    return "please fill ${widget.hint}";
                  }
                  null; 
                   
                 // return "please fill ${widget.hint}";
                  
                } ,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon:widget.isPassword ? GestureDetector(
                    onTap: _togglePassword,
                    child: _obscureText ? Icon(CupertinoIcons.eye,color: AppColor.primaryColor,):Icon(CupertinoIcons.eye_slash , color: AppColor.primaryColor)) : null,
                  enabledBorder: OutlineInputBorder(  
                    borderSide: BorderSide(
                      color: Colors.white
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white
                    )
                  ),
                  hintText: widget.hint,
                  hintStyle: TextStyle(color: AppColor.primaryColor),
                  fillColor: Colors.white,
                  filled: true
                ),
              );
  }
}