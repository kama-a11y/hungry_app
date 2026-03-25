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
import 'package:hungryapp/feature/checkout/widget/checkout_summary.dart';
import 'package:hungryapp/feature/orderhistory/data/order_item_model.dart';
import 'package:hungryapp/feature/orderhistory/data/order_repo.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_snack_bar.dart';
import 'package:hungryapp/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'cash';

  CartRepo cartRepo = CartRepo();
  OrderRepo orderRepo = OrderRepo();

  bool saveLoading = false;
  bool isGuest = false;

  OrderModel? order;
  List<CartItemsModel> cartItems = [];
  List<OrderItemModel> requestItems = [];

  /// =========================
  /// Check Guest
  /// =========================
  Future<void> checkGuest() async {
    final token = await PrefHelper.getToken();

    if (!mounted) return;

    if (token == null || token.isEmpty) {
      setState(() {
        isGuest = true;
      });
    } else {
      await getOrderItems();
    }
  }

  /// =========================
  /// Get order items from cart
  /// =========================
  Future<void> getOrderItems() async {
    try {
      print('================= GET ORDER DEBUG START =================');

      final result = await cartRepo.getOrder();

      print('Order fetched successfully');
      print('order.items length from API: ${result.items.length}');

      for (int i = 0; i < result.items.length; i++) {
        final item = result.items[i];
        print(
          'cart item $i => productId: ${item.productId}, quantity: ${item.quantity}, spicy: ${item.spicy}',
        );
      }

      if (!mounted) return;

      setState(() {
        order = result;
        cartItems = order!.items;

        requestItems = cartItems.map((item) {
          final spicyValue =
              item.spicy is num ? (item.spicy as num).toDouble() : null;

          return OrderItemModel(
            productId: item.productId,
            quantity: item.quantity,
            spicy: (spicyValue != null && spicyValue >= 0.1) ? spicyValue : null,
            toppings: item.toppings.map((t) => t.id).toList(),
            sideOptions: item.sideOptions.map((s) => s.id).toList(),
          );
        }).toList();
      });

      print('requestItems created successfully');
      print('requestItems length after mapping: ${requestItems.length}');
      print('requestItems JSON: ${requestItems.map((e) => e.toJson()).toList()}');

      print('================= GET ORDER DEBUG END =================');
    } catch (e) {
      print('================= GET ORDER ERROR =================');
      print(e.toString());
      print('===============================================');

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

  /// =========================
  /// Save order
  /// =========================
  Future<bool> saveOrder() async {
    setState(() {
      saveLoading = true;
    });

    try {
      print('================= CHECKOUT DEBUG =================');
      print('requestItems length: ${requestItems.length}');

      for (int i = 0; i < requestItems.length; i++) {
        print('item $i => ${requestItems[i].toJson()}');
      }

      print('=================================================');

      await orderRepo.saveOrder(items: requestItems);

      if (!mounted) return false;

      setState(() {
        saveLoading = false;
      });

      return true;
    } catch (e) {
      if (!mounted) return false;

      setState(() {
        saveLoading = false;
      });

      String errorMsg = 'Error in Order';
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(errorMsg, false),
      );

      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkGuest();
  }

  @override
  Widget build(BuildContext context) {
  
    if (isGuest) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.person_crop_circle_badge_exclam,
                size: 80,
                color: AppColor.primaryColor.withOpacity(.5),
              ),
              const SizedBox(height: 20),
              CustomText(
                text: 'You are browsing as Guest',
                size: 20,
                weight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: 'Please login to continue checkout',
                size: 14,
                color: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Go To Login',
                width: double.infinity,
                height: 55,
                ontap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              order == null
                  ? const Center(child: CupertinoActivityIndicator())
                  : CheckoutSummary(orderPrice: order!.totalPrice),
              const Gap(35),

              CustomText(
                text: 'Payment methods',
                size: 25,
                weight: FontWeight.bold,
              ),
              const Gap(15),

              /// cash
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () => setState(() => selectedMethod = 'cash'),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  leading: Image.asset(
                    'assets/checkout/dollar Background Removed 1.png',
                    width: 70,
                  ),
                  title: CustomText(
                    text: 'Cash on Delivery',
                    size: 22,
                    color: Colors.white,
                  ),
                  tileColor: const Color(0xff3C2F2F),
                  trailing: Radio<String>(
                    value: 'cash',
                    groupValue: selectedMethod,
                    activeColor: Colors.blue,
                    onChanged: (v) => setState(() => selectedMethod = v!),
                  ),
                ),
              ),
              const Gap(20),

              /// visa
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF3F4F6),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () => setState(() => selectedMethod = 'visa'),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  leading: Image.asset(
                    'assets/checkout/visa.png',
                    width: 70,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Debit card',
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text: '3566 **** **** 0505',
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  tileColor: const Color(0xffF3F4F6),
                  trailing: Radio<String>(
                    value: 'visa',
                    groupValue: selectedMethod,
                    activeColor: Colors.blue,
                    onChanged: (v) => setState(() => selectedMethod = v!),
                  ),
                ),
              ),

              Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    activeColor: const Color(0xffEF2A39),
                    value: true,
                    onChanged: (v) {},
                  ),
                  Expanded(
                    child: CustomText(
                      text: 'Save card details for future payments',
                      size: 16.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),

              const Gap(300),
            ],
          ),
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
                    text: 'Total price',
                    size: 17,
                    weight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.money_dollar,
                        color: AppColor.primaryColor,
                        size: 40,
                      ),
                      order == null
                          ? const CupertinoActivityIndicator()
                          : CustomText(
                              text: order!.totalPrice,
                              size: 28,
                              weight: FontWeight.bold,
                            ),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              CustomButton(
                text: saveLoading ? 'paying...' : 'Pay Now',
                width: 200,
                height: 70,
                ontap: () async {
                  if (saveLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please wait, payment is processing...'),
                      ),
                    );
                    return;
                  }

                  if (requestItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please wait a moment, your order is still loading...',
                        ),
                      ),
                    );
                    return;
                  }

                  final success = await saveOrder();

                  if (!mounted) return;

                  if (success) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal: 15,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/checkout/success.png',
                                  height: 70,
                                ),
                                const Gap(15),
                                CustomText(
                                  text: 'Success !',
                                  size: 26,
                                  color: AppColor.primaryColor,
                                  weight: FontWeight.bold,
                                ),
                                const Gap(15),
                                CustomText(
                                  text:
                                      'Your payment was successful.\nA receipt for this purchase has \nbeen sent to your email.',
                                  size: 16,
                                  color: Colors.grey.shade500,
                                ),
                                const Gap(30),
                                CustomButton(
                                  text: 'Close',
                                  ontap: () {
                                    Navigator.pop(context);
                                  },
                                  width: 170,
                                  height: 70,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}