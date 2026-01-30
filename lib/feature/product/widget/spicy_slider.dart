
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});
final double value;
final ValueChanged<double> onChanged;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Image.asset('assets/product/pngwing 12.png',height: 300,),
              Gap(10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Customize Your Burger \n to Your Tastes. Ultimate \n Experience', size: 16),
                       Gap(10),
                      CustomText(text: 'Spicy', size: 15,weight: FontWeight.bold,), 
                    ],
                  ),
               
                    Slider(
                      min: 0,
                      max: 1,
                      value: widget.value,
                      activeColor: AppColor.primaryColor,
                      inactiveColor: Colors.grey,
                       onChanged: widget.onChanged
                       ),
                  
                
                  Row(
                    children: [
                      CustomText(text:'🥶', size: 16),
                    Gap(110),
                      CustomText(text:'🌶', size: 16),

                    ]
                  ), 
                ],
              )
            ],
          );
  }
}