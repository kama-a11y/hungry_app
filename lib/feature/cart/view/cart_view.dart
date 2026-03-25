import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';
import 'package:hungryapp/feature/auth/view/login_view.dart';
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
  bool deleteLoading = false;
  CartRepo cartRepo = CartRepo();

  bool isGuest = false;
  bool isCheckingGuest = true;

  /// Check guest mode first
  Future<void> checkGuestStatus() async {
    final guest = await PrefHelper.isGuestMode();

    if (!mounted) return;

    setState(() {
      isGuest = guest;
      isCheckingGuest = false;
    });

    if (!guest) {
      await getCartItems();
    }
  }

  /// get cart items
  Future<void> getCartItems() async {
    try {
      final result = await cartRepo.getOrder();
      if (!mounted) return;
      setState(() {
        order = result;
        cartItems = order!.items;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in cart';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(errorMsg, false),
      );
    }
  }

  /// delete from cart
  Future<void> deleteFromCart(int itemId) async {
    setState(() {
      deleteLoading = true;
    });

    try {
      await cartRepo.deleteFromCart(itemId);

      if (!mounted) return;

      await getCartItems(); 

      setState(() {
        deleteLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar('Delete item successfully', true),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        deleteLoading = false;
      });

      String errorMsg = 'Error in cart';
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(errorMsg, false),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkGuestStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (isCheckingGuest) {
      return const Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    if (isGuest) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: AppColor.primaryColor.withOpacity(.4),
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: 'Please login to access your cart',
                  size: 20,
                  weight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(height: 12),
                CustomText(
                  text: 'Your cart is available only for logged in users',
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Go To Login',
                  width: double.infinity,
                  height: 55,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => await getCartItems(),
      child: Scaffold(
        body: Skeletonizer(
          enabled: order == null,
          containersColor: AppColor.primaryColor,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: cartItems.length,
            padding: const EdgeInsets.only(bottom: 120, top: 30),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return CartItem(
                image: item.image,
                title: item.name,
                price: item.price,
                quantity: item.quantity,
                ontap: () async {
                  await deleteFromCart(item.itemId);
                },
              );
            },
          ),
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
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    CustomText(
                      text: 'Total',
                      size: 20,
                      weight: FontWeight.bold,
                      color: const Color(0xff3C2F2F),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar,
                          color: AppColor.primaryColor,
                          size: 40,
                        ),
                        order?.totalPrice == null
                            ? const CupertinoActivityIndicator()
                            : CustomText(
                                text: order!.totalPrice,
                                size: 28,
                                weight: FontWeight.bold,
                              ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                CustomButton(
                  text: 'Checkout',
                  width: 200,
                  height: 70,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutView(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}