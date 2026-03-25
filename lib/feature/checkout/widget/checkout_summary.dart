import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CheckoutSummary extends StatefulWidget {
  const CheckoutSummary({super.key, required this.orderPrice});
 final String orderPrice;

  @override
  State<CheckoutSummary> createState() => _CheckoutSummaryState();
}

class _CheckoutSummaryState extends State<CheckoutSummary> {
 final double Taxes = 0.3;

 final double deliveryFees = 1.5;


  @override
  Widget build(BuildContext context) {

    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Order summary', size: 24,weight: FontWeight.bold,),
              Gap(20),
              checkoutText('Order','\$${widget.orderPrice}',false,false),
              Gap(10),
              checkoutText('Taxes','\$${Taxes}',false,false),
              Gap(10),
              checkoutText('Delivery fees','\$${deliveryFees}',false,false),
              Gap(10),
              Divider(),
              Gap(10),
              checkoutText('Total:','\$${widget.orderPrice}',true,true),
              Gap(20),
              checkoutText('Estimated delivery time:','15 - 30 mins',false,true),
              Gap(10),

            ]
            );
  }
}
Widget checkoutText(Text1, Text2, isbold,isblack) {
  return Row(
    children: [
      CustomText(
        text: Text1,
        size: 18,
        weight: isbold ? FontWeight.bold : FontWeight.w500,
        color: isblack ? Colors.black : Colors.grey.shade600,
      ),
      Spacer(),
      CustomText(
        text: Text2,
        size: 19,
        weight: isbold ? FontWeight.bold : FontWeight.w500,
        color: isblack ? Colors.black : Colors.grey.shade600,
      ),
    ],
  );
}
