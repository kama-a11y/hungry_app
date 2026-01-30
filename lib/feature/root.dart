
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/feature/auth/view/profile_view.dart';
import 'package:hungryapp/feature/cart/view/cart_view.dart';
import 'package:hungryapp/feature/home/view/home_view.dart';
import 'package:hungryapp/feature/orderhistory/view/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

 late PageController controller;
 late  List<Widget> screens;
  int currentScreen = 0;
 @override
  void initState() {
    controller =PageController(initialPage: currentScreen);
    screens = [
      HomeView(),
      CartView(),
      OrderHistoryView(),
      ProfileView()
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller:controller ,
        children : screens,
        physics: NeverScrollableScrollPhysics(),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        
        decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))  
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
           currentIndex: currentScreen,
          onTap: (index) {
            setState(() {
            currentScreen = index ;
            });
            controller.jumpToPage(currentScreen);
          },    
           items: [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart),label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.local_restaurant_sharp),label: 'Order History'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),label: 'Profile'),
          ]
          ),
      ),
    );
  }
}