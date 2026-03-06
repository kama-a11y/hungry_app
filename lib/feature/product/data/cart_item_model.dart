class CartItemModel {
  final int productId;
  final int quantity;
  final double? spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  // ✅ تحويل من Object لـ JSON (للإرسال للـ API)
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      if (spicy != null) 'spicy': spicy, // لو موجودة فقط
      'toppings': toppings,
      'side_options': sideOptions,
    };
  }

  // ✅ تحويل من JSON لـ Object (لو جاي من API)
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'],
      quantity: json['quantity'],
      spicy: json['spicy']?.toDouble(),
      toppings: List<int>.from(json['toppings'] ?? []),
      sideOptions: List<int>.from(json['side_options'] ?? []),
    );
  }
}