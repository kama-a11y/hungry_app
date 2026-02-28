
import 'package:flutter/material.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/feature/home/data/category_model.dart';
import 'package:hungryapp/shared/custom_text.dart';

// ignore: must_be_immutable
class FoodCategory extends StatefulWidget {
   FoodCategory({super.key, required this.category, required this.selectedCategory});
 List<CategoryModel> category;
 int selectedCategory;
  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(widget.category.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                             widget.selectedCategory = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(
                              horizontal: 27,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: widget.selectedCategory == index
                                  ? AppColor.primaryColor
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            
                            child: Center(
                              child: CustomText(
                                text: widget.category[index].name,
                                size: 16,
                                weight: FontWeight.bold,
                                color: widget.selectedCategory == index
                                    ? Colors.white
                                    : Colors.grey.shade500,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
  }
}