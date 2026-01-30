
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/feature/checkout/widget/checkout_summary.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'cash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckoutSummary(),
                Gap(35),
              CustomText(text: 'Payment methods', size: 25,weight: FontWeight.bold,),
              Gap(15),
              ///cash
              Container(
                decoration: BoxDecoration(
                   boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () => setState(()=> selectedMethod = 'cash' ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 15),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16)
                  ),
                  leading:Image.asset('assets/checkout/dollar Background Removed 1.png',width: 70,) ,
                  title: CustomText(text: 'Cash on Delivery', size: 22,color: Colors.white),
                  tileColor:Color(0xff3C2F2F) ,
                  trailing: Radio<String>(
                    value: 'cash',
                    groupValue: selectedMethod,
                    activeColor: Colors.blue,
                    onChanged: (v)=>setState(()=> selectedMethod = v! ),
                    ),
                ),
              ),
              Gap(20),
              /// visa
              Container(
                decoration: BoxDecoration(
                  color:Color(0xffF3F4F6) ,
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
                child: ListTile(
                  onTap: () => setState(()=> selectedMethod = 'visa' ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 13),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16)
                  ),
                  leading:Image.asset('assets/checkout/visa.png',width: 70,) ,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Debit card', size: 16,weight: FontWeight.bold,),
                      CustomText(text: '3566 **** **** 0505', size: 16,color: Colors.grey.shade600),
                    ],
                  ),
                  tileColor:Color(0xffF3F4F6) ,
                  trailing: Radio<String>(
                    value: 'visa',
                    groupValue: selectedMethod,
                    activeColor:  Colors.blue,
                    onChanged: (v)=>setState(()=> selectedMethod = v! ),
                    ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(4)
                    ),
                    activeColor: Color(0xffEF2A39),
                    value: true,
                     onChanged: (v){}),
                      CustomText(text: 'Save card details for future payments', size: 16.5,color: Colors.grey.shade700),
                ],
              ),
              Gap(300)
              ],
          ),
        ),
      ),

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
                            CustomText(text: 'Total price', size: 17,weight: FontWeight.bold,color: Colors.grey.shade600,),
                            Gap(10),
                            Row(
                              
                              children: [
                      Icon(
                        CupertinoIcons.money_dollar,
                        color: AppColor.primaryColor,
                        size: 40,
                      ),
                      CustomText(
                        text: '18.19',
                        size: 28,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                text: 'Pay Now',
                width: 200,
                height: 70,
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (context){
                     return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 15),
                        child: Container(
                           width: double.infinity,
                            child:Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/checkout/success.png',height: 70,),
                                Gap(15),
                                CustomText(text: 'Success !', size: 26,color: AppColor.primaryColor,weight: FontWeight.bold,),
                                 Gap(15),
                                CustomText(text: 'Your payment was successful.\nA receipt for this purchase has \nbeen sent to your email.', size: 16,color: Colors.grey.shade500),
                                Gap(30),
                                CustomButton(text: 'Close',
                                 ontap: (){
                                  Navigator.pop(context);
                                }, width: 170, height: 70)
                              ],
                            ) ,
                          ),
                      ),
                      
                     ); 
                    });
                },
              ),
            ],
                    ),
        ) ,
      ),
    );
  }
}

