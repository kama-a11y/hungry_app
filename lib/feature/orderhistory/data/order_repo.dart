
import 'package:dio/dio.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/network/api_exceptions.dart';
import 'package:hungryapp/core/network/api_service.dart';
import 'package:hungryapp/feature/orderhistory/data/order_item_model.dart';
import 'package:hungryapp/feature/orderhistory/data/orders_history_model.dart';
import 'package:hungryapp/feature/orderhistory/data/orders_model.dart';

class OrderRepo {
 ApiService apiService = ApiService();
 ///get orders history
  Future<OrdersHistoryModel> getOrder()async{
  try {
    final Response = await apiService.get("/orders");
    final OrdersHistoryModel order = OrdersHistoryModel.fromJson(Response);
        return order ;          
  } on DioError catch(e) {
      throw ApiExceptions.handleError(e);
    }catch(e){
      throw ApiError(message: e.toString());
    }
  }

//save order
Future<Map<String, dynamic>?> saveOrder({
  required List<OrderItemModel> items,
}) async {
  try {
    final cart = OrdersModel(items: items);

    final response = await apiService.post('/orders', cart.toJson());

    if (response is ApiError) {
      throw response;
    }
    if (response is Map<String, dynamic>) {
      final msg = response['message'];
      final code = response['code'];
      final coder = code is int ? code : int.tryParse(code?.toString() ?? '0');

      if (coder != 200 && coder != 201) {
        throw ApiError(message: msg ?? 'Unknown error');
      }
      return response;
    } else {
      throw ApiError(message: 'Unexpected Error From Server');
    }
  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
  } catch (e) {
    throw ApiError(message: e.toString());
  }
}

}
