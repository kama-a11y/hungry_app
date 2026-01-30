import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/feature/cart/widget/cart_item.dart';
import 'package:hungryapp/feature/checkout/view/checkout_view.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext   context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
          itemCount: 4,
          padding: EdgeInsets.only(bottom: 120, top: 30 ),
          itemBuilder: (context,index){
            return CartItem(
              image: 'assets/cart/Group 1000000811.png',
              title: 'Hamburger',
              description: 'Veggie Burger',
            );
          }),
      bottomSheet: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start  ,
                          children: [
                            Gap(10),
                            CustomText(text: 'Total', size: 20,weight: FontWeight.bold,color: Color(0xff3C2F2F),),
                            Gap(10),
                            Row(
                              
                              children: [
                                Icon(CupertinoIcons.money_dollar,color: AppColor.primaryColor,size: 40,),
                                CustomText(text: '99.19', size: 28,weight: FontWeight.bold,)
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                       
                       CustomButton(
                        text: 'Checkout',
                        width: 200,
                        height: 70,
                        ontap: (){
                        Navigator.push( context , MaterialPageRoute( builder : (context) => CheckoutView()));
                      },)
                      ],
                    ),
        ) ,
      ),
    );
  }
}