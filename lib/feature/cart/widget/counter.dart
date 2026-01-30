
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/shared/custom_text.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
 int count = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if(count > 0){
                                count--;
                              }else{
                                count = count;
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
                        CustomText(text: '$count', size: 23),
                        Gap(20),
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              count++;
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