class OrderItemModel {
  final int productId;
  final int quantity;
  final double? spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  OrderItemModel({
    required this.productId,
    required this.quantity,
    this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'product_id': productId,
      'quantity': quantity,
      'toppings': toppings,
      'side_options': sideOptions,
    };
    if (spicy != null) {
      data['spicy'] = spicy;
    }
    return data;
  }

  
}