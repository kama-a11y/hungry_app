import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/feature/home/data/product_model.dart';
import 'package:hungryapp/feature/product/data/option_model.dart';
import 'package:hungryapp/feature/product/data/product_repo.dart';
import 'package:hungryapp/feature/product/widget/spicy_slider.dart';
import 'package:hungryapp/feature/product/widget/topping_item.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_snack_bar.dart';
import 'package:hungryapp/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.id});
  final int id;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = .5;
  int quantity = 1;
List<int> toppingIds = [];
List<int> optionIds = [];
bool addLoading = false;
 ProductModel? productModel;
List<OptionModel>? toppings;
List<OptionModel>? sideOptions;
ProductRepo productRepo = ProductRepo();
   ///get product info
  Future<void> getProductInfo() async {
    try {
      final product = await productRepo.getProductInfo(widget.id+1);
      if (!mounted) return;
      setState(() {
        productModel = product;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg,false));
    }
  }

   ///get toppings
  Future<void> getToppings() async {
    try {
      final result = await productRepo.getToppings();
      if (!mounted) return;
      setState(() {
        toppings = result;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg,false));
    }
  }

     ///get side Options
  Future<void> getSideOptions() async {

    try {
      final result = await productRepo.getSideOptions();
      if (!mounted) return;
      setState(() {
        sideOptions = result;
      });

    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg,false));
    }
  }

  ///add to cart
  Future<void> addToCart()async{
    setState(() {
      addLoading = true;
    });
    try {
     await productRepo.addToCart(
        productId: widget.id + 1 ,
        quantity:quantity,
        spicy:value ,
        toppings: toppingIds,
        sideOptions: optionIds);
      if (!mounted) return;
    setState(() {
      addLoading = false;
    });
        // ✅ رسالة نجاح
        
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar('Added to cart successfully',true));


    } catch (e) {
       if (!mounted) return;
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg,false));
    }
  }

  @override
  void initState() {
    getProductInfo();
    getToppings();
    getSideOptions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:  () async => await getProductInfo(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Skeletonizer(
        enabled: productModel == null && toppings == null && sideOptions == null, // لو null شغل اللودينج
        child: 
        // productModel == null && toppings == null
        //     ? _buildLoadingUI() // ⭐ واجهة وهمية
             _buildRealUI(),   // ⭐ الواجهة الحقيقية
      ),
       ),
    );
  }

  
 // ⭐ واجهة اللودينج
  Widget _buildLoadingUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 250, width: double.infinity),
          Gap(40),
          SizedBox(height: 20, width: 150),
          Gap(20),
          SizedBox(height: 80, width: double.infinity),
        ],
      ),
    );
  }

  // ⭐ الواجهة الحقيقية (هنا مسموح نستخدم !)
  Widget _buildRealUI() {
    if (productModel == null || toppings == null || sideOptions == null) {
    return _buildLoadingUI();
  }
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpicySlider(
                    value: value,
                    onChanged: (v) {
                      setState(() {
                        value = v;
                      });
                    }, image: productModel!.image, name: productModel!.name, description: productModel!.description,
                  ),
                  Gap(40),
                  CustomText(text: 'Toppings', size: 18, weight: FontWeight.bold),
                  Gap(20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    child: Row(
                      children:(toppings ?? []).map((item) {
                         final istoppingClicked = toppingIds.contains(item.id);
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: ToppingItem(
                              image: item.image,
                              title: item.name,
                              isclicked: istoppingClicked,
                              ontap:  () {
                        setState(() {
                          if (istoppingClicked) {
                            toppingIds.remove(item.id); // إلغاء
                          } else {
                            toppingIds.add(item.id); // إضافة
                          }
                        });
                      },
                            ),
                          );
                        }).toList(),
                    ),
                  ),
              
                  Gap(40),
                  CustomText(text: 'Side options', size: 18, weight: FontWeight.bold),
                  Gap(20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    child: Row(
                      children:(sideOptions ?? []).map((item) {
                        final isoptionClicked = optionIds.contains(item.id);
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: ToppingItem(
                              image: item.image,
                              title: item.name,
                              isclicked: isoptionClicked,
                              ontap:  () {
                        setState(() {
                          if (isoptionClicked) {
                            optionIds.remove(item.id); // إلغاء
                          } else {
                           optionIds.add(item.id); // إضافة
                          }
                        });
                        print('topping list is : $optionIds');
                      },
                      
                            ),
                          );
                        }).toList(),
                    ),
                  ),
                  Gap(50),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start  ,
                        children: [
                          CustomText(text: 'Total', size: 20,weight: FontWeight.bold,),
                          Gap(10),
                          Row(
                            
                            children: [
                              Icon(CupertinoIcons.money_dollar,color: AppColor.primaryColor,size: 40,),
                              CustomText(text: productModel!.price, size: 26,weight: FontWeight.bold,)
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                     
                     CustomButton(text:addLoading?'Adding...' : 'Add To Cart',width: 200,height: 70, ontap: ()=>addToCart())
                    ],
                  ),
                
                  Gap(40)
                  
                ],
              ),
            ),
          );
  }

}
