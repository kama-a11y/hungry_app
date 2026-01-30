
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_text.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.image, required this.title, required this.quantity, required this.price});
  final String image ;
  final String title ;
  final String quantity;
  final String price;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          height: 230,
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Image.asset(image,height: 120),
                     
                     Spacer(),
                     
                     Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                CustomText(text:title, size: 18, weight: FontWeight.bold,),
                                Gap(5),
                                CustomText(text:quantity, size: 16, weight: FontWeight.w700,),
                                Gap(5),
                                CustomText(text:price, size: 16, weight: FontWeight.w700,),
                                          
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
              ),
              Gap(10),
              CustomButton(text: 'Order Again', ontap: (){}, width: 350, height: 62,color: Colors.grey.shade500,),
              Gap(10)
            ],
          ),
        ),
      );
    //''

  }
}