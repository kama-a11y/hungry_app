import 'package:hungryapp/feature/orderhistory/data/order_history_model.dart';

class OrdersHistoryModel {
  final int code;
  final String message;
  final List<OrderHistoryModel> data;

  OrdersHistoryModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory OrdersHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrdersHistoryModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => OrderHistoryModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}