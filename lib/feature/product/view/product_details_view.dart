import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/feature/product/widget/spicy_slider.dart';
import 'package:hungryapp/feature/product/widget/topping_item.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = .5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                value: value,
                onChanged: (v) {
                  setState(() {
                    value = v;
                  });
                },
              ),
              Gap(40),
              CustomText(text: 'Toppings', size: 18, weight: FontWeight.bold),
              Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                clipBehavior: Clip.none,
                child: Row(
                  children:List.generate(4, (index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: ToppingItem(image:'assets/product/tomato.png', title: 'Tomato', ontap: (){}),
                    );
                  }) ,
                ),
              ),
          
              Gap(40),
              CustomText(text: 'Side options', size: 18, weight: FontWeight.bold),
              Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                clipBehavior: Clip.none,
                child: Row(
                  children:List.generate(4, (index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: ToppingItem(image:'assets/product/tomato.png', title: 'Tomato', ontap: (){}),
                    );
                  }) ,
                ),
              ),
              Gap(50),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start  ,
                    children: [
                      CustomText(text: 'Total', size: 20,weight: FontWeight.bold,),
                      Gap(10),
                      Row(
                        
                        children: [
                          Icon(CupertinoIcons.money_dollar,color: AppColor.primaryColor,size: 40,),
                          CustomText(text: '18.19', size: 26,weight: FontWeight.bold,)
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                 
                 CustomButton(text: 'Add To Cart',width: 200,height: 70, ontap: (){})
                ],
              ),

              Gap(40)
              
            ],
          ),
        ),
      ),
    );
  }
}
