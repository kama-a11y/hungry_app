import 'package:flutter/material.dart';
import 'package:hungryapp/feature/orderhistory/widget/order_item.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
          itemCount: 4,
          padding: EdgeInsets.only(bottom: 10, top: 30 ),
          itemBuilder: (context,index){
            return OrderItem(
              image: 'assets/test/burger.png',
              title: 'Hamburger',
              quantity: 'Qty : X3',
              price: 'Price : 20\$',) ;
          }),
    );
  }
}