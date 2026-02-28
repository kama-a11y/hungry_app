import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/feature/home/data/category_model.dart';
import 'package:hungryapp/feature/home/data/product_model.dart';
import 'package:hungryapp/feature/home/data/home_repo.dart';
import 'package:hungryapp/feature/home/widget/card_item.dart';
import 'package:hungryapp/feature/home/widget/food_category.dart';
import 'package:hungryapp/feature/home/widget/search_field.dart';
import 'package:hungryapp/feature/home/widget/user_header.dart';
import 'package:hungryapp/feature/product/view/product_details_view.dart';
import 'package:hungryapp/shared/custom_snack_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CategoryModel>? category ;

  int selectedCategory = 0;
  bool isclicked = false;

 List<ProductModel>? products;
 List<ProductModel>? filteredProducts = [];

  HomeRepo homeRepo = HomeRepo();
  ///get categories
  Future<void> getCategories() async {
    try {
      final result = await homeRepo.getCategories();
      if (!mounted) return;
      setState(() {
        category = result;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg));
    }
  }
  ///search product
  void searchProduct(String text) {
  if (products == null) return;
  if (!mounted) return; 
  setState(() {
    filteredProducts = products!
        .where((product) =>
            product.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  });
}

  ///get products
  Future<void> getProducts() async {
    try {
      final result = await homeRepo.getProducts();
      if (!mounted) return;
      setState(() {
        products = result;
        filteredProducts = result;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg));
    }
  }
@override
  void initState() {
    getProducts();
    getCategories();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await getProducts(),
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          body: Skeletonizer(
            enabled: products == null,
            containersColor: AppColor.primaryColor.withOpacity(0.3),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  toolbarHeight: 200,
                  backgroundColor: Colors.white,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                    child: Column(
                      children: [Gap(25), UserHeader(), Spacer(), SearchField(onChanged:searchProduct)],
                    ),
                  ),
                ),
                  
                ///app bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        /// category
                        Gap(20),
                        FoodCategory(
                          category: category??[],
                          selectedCategory: selectedCategory,
                        ),
                      ],
                    ),
                  ),
                ),
                  
                /// grid view
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.crossAxisExtent;
                  
                      // حساب عدد الأعمدة تلقائي
                      final crossAxisCount = width ~/ 180;
                      final itemWidth = width / crossAxisCount;
                  
                      // ارتفاع تقريبي للكارد (صورة + نص)
                      final itemHeight = itemWidth + 140;
                  
                      final aspectRatio = itemWidth / itemHeight;
                  
                      ///product
                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: filteredProducts?.length ?? 0,
                           (context,index) {
                            final product = filteredProducts![index];
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
                              image: product.image,
                              text: product.name,
                              desc: product.description,
                              rate: product.rating,
                            ),
                          );
                        }),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: aspectRatio,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
