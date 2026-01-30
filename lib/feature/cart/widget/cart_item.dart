
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/feature/cart/widget/counter.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.image, required this.title, required this.description});
final String image;
final String title;
final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white ,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(image,height: 120),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CustomText(text: title, size: 18, weight: FontWeight.bold,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CustomText(text: description, size: 19, weight: FontWeight.w500,),
                    ),
            
                  ],
                ),
                Gap(40),
                //second column
                Column(
                  children: [
                    Gap(25),
                    Counter(),
                    Gap(35),
                    CustomButton(text: 'Remove',width: 150,height: 50, ontap: (){})
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}