import 'package:hungryapp/feature/cart/data/models/side_option_model.dart';
import 'package:hungryapp/feature/cart/data/models/topping_model.dart';

class CartItemsModel {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final String price;
  final dynamic spicy; // Can be String or int
  final List<ToppingModel> toppings;
  final List<SideOptionModel> sideOptions;

  CartItemsModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) {
    return CartItemsModel(
      itemId: json['item_id'],
      productId: json['product_id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price']?.toString() ?? '0',
      spicy: json['spicy'], // Keep as dynamic
      toppings: (json['toppings'] as List?)
              ?.map((item) => ToppingModel.fromJson(item))
              .toList() ??
          [],
      sideOptions: (json['side_options'] as List?)
              ?.map((item) => SideOptionModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'product_id': productId,
      'name': name,
      'image': image,
      'quantity': quantity,
      'price': price,
      'spicy': spicy,
      'toppings': toppings.map((t) => t.toJson()).toList(),
      'side_options': sideOptions.map((s) => s.toJson()).toList(),
    };
  }
}