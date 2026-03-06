import 'package:hungryapp/feature/product/data/cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;

  CartModel({required this.items});

  // ✅ تحويل لـ JSON للإرسال
  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // ✅ تحويل من JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }
}