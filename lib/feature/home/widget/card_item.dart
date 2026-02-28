
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.image, required this.text, required this.desc, required this.rate});
 final String image , text , desc , rate ;
  @override
  Widget build(BuildContext context) {
    return Card(
              shadowColor: Colors.grey,
              margin: EdgeInsets.all(8),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric( horizontal: 20 , vertical: 8 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(image,width: 170,),
                    Gap(10),
                    CustomText(text: text, size: 17 ,weight: FontWeight.bold,),
                    CustomText(text: desc, size: 14 ,weight: FontWeight.w700,color: Color(0xff544949),),
                    CustomText(text: '⭐ $rate ', size: 17 ,weight: FontWeight.bold,),

                  ],
                ),
              ),
            );
  }
}