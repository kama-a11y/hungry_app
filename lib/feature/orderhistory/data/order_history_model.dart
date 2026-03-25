class OrderHistoryModel {
  final int id;
  final String status;
  final double totalPrice;
  final String createdAt;
  final String productImage;

  OrderHistoryModel({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.productImage,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      createdAt: json['created_at'] ?? '',
      productImage: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total_price': totalPrice.toStringAsFixed(2),
      'created_at': createdAt,
      'product_image': productImage,
    };
  }
}