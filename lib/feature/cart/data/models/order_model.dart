
import 'package:hungryapp/feature/cart/data/models/cart_item_model.dart';

class OrderModel {
  final int id;
  final String totalPrice;
  final List<CartItemsModel> items;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      totalPrice: json['total_price']?.toString() ?? '0',
      items: (json['items'] as List?)
              ?.map((item) => CartItemsModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_price': totalPrice,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}