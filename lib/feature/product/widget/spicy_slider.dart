
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged, required this.image, required this.name, required this.description});
final double value;
final ValueChanged<double> onChanged;
final String image;
final String name;
final String description;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(widget.image,width:screenWidth * 0.45,),
              Gap(10),
            //  Spacer(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         CustomText(text: widget.name, size: 18,weight: FontWeight.bold,),
                         Gap(10),
                         CustomText(text: widget.description, size: 16),
                         Gap(15),
                        CustomText(text: 'Spicy', size: 18,weight: FontWeight.bold,), 
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
                      Spacer(),
                        CustomText(text:'🌶', size: 16),
                
                      ]
                    ), 
                  ],
                ),
              )
            ],
          );
  }
}