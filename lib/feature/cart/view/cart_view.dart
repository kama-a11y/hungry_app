import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/feature/cart/data/cart_repo.dart';
import 'package:hungryapp/feature/cart/data/models/cart_item_model.dart';
import 'package:hungryapp/feature/cart/data/models/order_model.dart';
import 'package:hungryapp/feature/cart/widget/cart_item.dart';
import 'package:hungryapp/feature/checkout/view/checkout_view.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_snack_bar.dart';
import 'package:hungryapp/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
OrderModel? order;
List<CartItemsModel> cartItems = [];
bool deleteLoading =false;
CartRepo cartRepo =CartRepo();
  ///get cart items
  Future<void> getCartItems() async {
    try {
      final result = await cartRepo.getOrder();
      if (!mounted) return;
      setState(() {
        order = result;
        cartItems= order!.items;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in cart';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg,false));
    }
  }
  
    ///add to cart
  Future<void> deleteFromCart(int itemId)async{
    setState(() {
      deleteLoading = true;
    });
    try {
     await cartRepo.deleteFromCart(itemId);
      if (!mounted) return;
    setState(() {
      deleteLoading = false;
    });
        // ✅ رسالة نجاح
        
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar('Delete item successfully',true));

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
    getCartItems();
    super.initState();
  }
  @override
  Widget build(BuildContext   context) {
    return RefreshIndicator(
      onRefresh:  () async => await getCartItems(),
      child: Scaffold(
        body: Skeletonizer(
          enabled: order == null,
          containersColor: AppColor.primaryColor,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
              itemCount: cartItems.length ,
              padding: EdgeInsets.only(bottom: 120, top: 30 ),
              itemBuilder: (context,index){
                final item = cartItems[index];
                return CartItem(
                  image: item.image,
                  title: item.name,
                  price: item.price, 
                  quantity: item.quantity,
                   ontap: () { 
                    setState(() {
                    deleteFromCart(item.itemId);  
                    getCartItems();
                    });
                    
                    },
                );
              }),
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start  ,
                            children: [
                              Gap(10),
                              CustomText(text: 'Total', size: 20,weight: FontWeight.bold,color: Color(0xff3C2F2F),),
                              Gap(10),
                              Row(
                                
                                children: [
                                  Icon(CupertinoIcons.money_dollar,color: AppColor.primaryColor,size: 40,),
                                  order?.totalPrice == null ?
                                  CupertinoActivityIndicator() :
                                  CustomText(text: order!.totalPrice, size: 28,weight: FontWeight.bold,)
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                         
                         CustomButton(
                          text: 'Checkout',
                          width: 200,
                          height: 70,
                          ontap: (){
                          Navigator.push( context , MaterialPageRoute( builder : (context) => CheckoutView()));
                        },)
                        ],
                      ),
          ) ,
        ),
      ),
    );
  }
}