
import 'package:dio/dio.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/network/api_exceptions.dart';
import 'package:hungryapp/core/network/api_service.dart';
import 'package:hungryapp/feature/cart/data/models/cart_item_model.dart';
import 'package:hungryapp/feature/cart/data/models/order_model.dart';

class CartRepo {

 ApiService apiService = ApiService();
  ///get order
  Future<OrderModel> getOrder()async{
  try {
    final Response = await apiService.get("/cart");
    final OrderModel order = OrderModel.fromJson(Response['data']);
        return order ;
            // .map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
            // .toList();
            
  } on DioError catch(e) {
      throw ApiExceptions.handleError(e);
    }catch(e){
      throw ApiError(message: e.toString());
    }
  }
  /// Delete item from cart
  Future<Map<String, dynamic>?> deleteFromCart(int cartItemId) async {
    try {
      // إرسال طلب الحذف باستخدام المعرف في المسار
      final response = await apiService.delete('/cart/remove/$cartItemId');

      // التحقق إذا كان الرد خطأ من نوع ApiError
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final String? msg = response['message']?.toString();
        final dynamic rawCode = response['code'];
        
        // معالجة الكود بمرونة (رقم أو نص) لمنع خطأ الـ Subtype
        final int? coder = rawCode is int ? rawCode : int.tryParse(rawCode?.toString() ?? '0');

        if (coder != 200) {
          throw ApiError(message: msg ?? 'Failed to delete item');
        }

        return response; // إرجاع الرد في حالة النجاح (200 OK)
      } else {
        throw ApiError(message: 'Unexpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      // التأكد من تحويل أي خطأ لنص لمنع تعارض الأنواع
      throw ApiError(message: e.toString());
    }
  }

  ///add to cart
  Future<Map<String, dynamic>?> saveOrderModel({required List<CartItemsModel> items,}) async {
    try {
      final cart = items;
      // إرسال الطلب
      final response = await apiService.post('/orders', cart);

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

        return response; // إرجاع الـ response كامل
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