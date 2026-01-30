import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Order summary', size: 24,weight: FontWeight.bold,),
              Gap(20),
              checkoutText('Order','\$16.48',false,false),
              Gap(10),
              checkoutText('Taxes','\$0.3',false,false),
              Gap(10),
              checkoutText('Delivery fees','\$1.5',false,false),
              Gap(10),
              Divider(),
              Gap(10),
              checkoutText('Total:','\$18.19',true,true),
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
