import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';
import 'package:hungryapp/feature/auth/view/login_view.dart';
import 'package:hungryapp/feature/orderhistory/data/order_history_model.dart';
import 'package:hungryapp/feature/orderhistory/data/order_repo.dart';
import 'package:hungryapp/feature/orderhistory/data/orders_history_model.dart';
import 'package:hungryapp/feature/orderhistory/widget/order_item.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_snack_bar.dart';
import 'package:hungryapp/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  OrdersHistoryModel? order;
  List<OrderHistoryModel> orderItems = [];
  OrderRepo orderRepo = OrderRepo();

  bool isGuest = false;

  /// check guest
  Future<void> checkGuest() async {
    final token = await PrefHelper.getToken();

    if (!mounted) return;

    if (token == null || token.isEmpty) {
      setState(() {
        isGuest = true;
      });
    } else {
      await getOrder();
    }
  }

  /// get orders history
  Future<void> getOrder() async {
    try {
      final result = await orderRepo.getOrder();
      if (!mounted) return;
      setState(() {
        order = result;
        orderItems = order!.data;
      });
    } catch (e) {
      if (!mounted) return;
      String errorMsg = 'Error in order history';
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
    checkGuest();
  }

  @override
  Widget build(BuildContext context) {
    
    if (isGuest) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.clock_fill,
                size: 80,
                color: AppColor.primaryColor.withOpacity(.4),
              ),
              const SizedBox(height: 20),
              CustomText(
                text: 'Please login to view your order history',
                size: 20,
                weight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: 'Your orders is available only for logged in users',
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
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => await getOrder(),
      child: Scaffold(
        body: Skeletonizer(
          enabled: order == null,
          containersColor: AppColor.primaryColor,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: orderItems.length,
            padding: EdgeInsets.only(bottom: 10, top: 30),
            itemBuilder: (context, index) {
              final item = orderItems[index];
              return OrderItem(
                image: item.productImage,
                title: 'Hamburger',
                quantity: 'Created at : ${item.createdAt}',
                price: 'Price : ${item.totalPrice}\$',
              );
            },
          ),
        ),
      ),
    );
  }
}