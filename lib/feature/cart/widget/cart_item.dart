import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/feature/cart/widget/counter.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.ontap,
  });
  final String image;
  final String title;
  final String price;
  final int quantity;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.white,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(image, height: 130),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: CustomText(
                        text: title,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        price,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        textScaler: TextScaler.linear(1.0),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             // Spacer(),
              //second column
              Column(
                children: [
                  Gap(35),
                  Counter(quantity: quantity),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: CustomButton(
                      text: 'Remove',
                      width: 130,
                      height: 50,
                      ontap:ontap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
