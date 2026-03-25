import 'package:hungryapp/feature/orderhistory/data/order_item_model.dart';

class OrdersModel {
  final List<OrderItemModel> items;

  OrdersModel({required this.items});

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}