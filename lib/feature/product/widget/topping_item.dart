import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/shared/custom_text.dart';

class ToppingItem extends StatelessWidget {
  const ToppingItem({super.key, required this.image, required this.title, required this.ontap});
  final String image;
  final String title;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xff3C2F2F),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 75,
                    child: Image.asset(image,scale: 3,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CustomText(text: title, size: 14,weight: FontWeight.bold,color: Colors.white,),
                        Gap(12),
                        GestureDetector(
                          onTap:ontap,
                          child: CircleAvatar(
                            radius: 11,
                            backgroundColor: Color(0xffEF2A39),
                            child: Center(child: Icon(CupertinoIcons.add,color: Colors.white,size: 15,)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
  }
}