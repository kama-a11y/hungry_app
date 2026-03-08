
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/shared/custom_text.dart';

// ignore: must_be_immutable
class Counter extends StatefulWidget {
   Counter({super.key, required this.quantity});
 int quantity;
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
 //int count = widget.quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if(widget.quantity > 0){
                                widget.quantity--;
                              }else{
                                widget.quantity = widget.quantity;
                              }
                              
                            });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            padding: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(Icons.minimize_outlined,size: 25,color: Colors.white,),
                          ),
                        ),
                        Gap(20),
                        CustomText(text: '${widget.quantity}', size: 23),
                        Gap(20),
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              widget.quantity++;
                            });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(Icons.add,size: 25,color: Colors.white,),
                          ),
                        ),
                          
                      ],
                    );
  }
}