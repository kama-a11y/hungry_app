import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/feature/home/widget/card_item.dart';
import 'package:hungryapp/feature/home/widget/food_category.dart';
import 'package:hungryapp/feature/home/widget/search_field.dart';
import 'package:hungryapp/feature/home/widget/user_header.dart';
import 'package:hungryapp/feature/product/view/product_details_view.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combo', 'Slider', 'Class'];

  int selectedCategory = 0;
  bool isclicked = false;
  
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            
            SliverAppBar(
              toolbarHeight: 200,
              backgroundColor: Colors.white,
             flexibleSpace:Padding(
               padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
               child: Column(
                  children: [
                    Gap(25),
                     UserHeader(),  
                    Spacer(),                     
                    SearchField(),   
                  ],
               ),
             ) ,
            ),
            
            ///app bar
            SliverToBoxAdapter(
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                children: [
                  
                        

                  /// category
                  Gap(20),
                  FoodCategory(category: category, selectedCategory: selectedCategory)
                ],
                            ),
              ), 
            ),


            /// grid view
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
              sliver: SliverLayoutBuilder(
  builder: (context, constraints) {
    final width = constraints.crossAxisExtent;

    // حساب عدد الأعمدة تلقائي
    final crossAxisCount = width ~/ 180;
    final itemWidth = width / crossAxisCount;

    // ارتفاع تقريبي للكارد (صورة + نص)
    final itemHeight = itemWidth +100;

    final aspectRatio = itemWidth / itemHeight;

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: 6,
        (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsView(),
                ),
              );
            },
            child: CardItem(
              image: 'assets/test/burger.png',
              text: 'Cheeseburger',
              desc: "Wendy's Burger",
              rate: '4.9',
            ),
          );
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: aspectRatio,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
    );
  },
),

              )


          ],
        ) 
        
       
        ),
      
    );
  }
}
