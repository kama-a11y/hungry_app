import 'package:dio/dio.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/network/api_exceptions.dart';
import 'package:hungryapp/core/network/api_service.dart';
import 'package:hungryapp/feature/home/data/product_model.dart';
import 'package:hungryapp/feature/product/data/cart_item_model.dart';
import 'package:hungryapp/feature/product/data/cart_model.dart';
import 'package:hungryapp/feature/product/data/option_model.dart';

class ProductRepo {
  ApiService apiService = ApiService();

  ///get product info
  Future<ProductModel> getProductInfo(int id) async {
    try {
      final Response = await apiService.get("/products/$id");
      return ProductModel.fromJson(Response['data']);
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///get toppings
  Future<List<OptionModel>> getToppings() async {
    try {
      final Response = await apiService.get("/toppings");
      final List toppings = Response['data'];
      return toppings.map((topping) => OptionModel.fromJson(topping)).toList();
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///get side options
  Future<List<OptionModel>> getSideOptions() async {
    try {
      final Response = await apiService.get("/side-options");
      final List sideOptions = Response['data'];
      return sideOptions.map((option) => OptionModel.fromJson(option)).toList();
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
///add to cart
  Future<Map<String, dynamic  >?> addToCart({
    required int productId,
    required int quantity,
    double? spicy,
    required List<int> toppings,
    required List<int> sideOptions,
  }) async {
    try {
      // إنشاء cart item
      final cartItem = CartItemModel(
        productId: productId,
        quantity: quantity,
        spicy: spicy,
        toppings: toppings,
        sideOptions: sideOptions,
      );

      // إنشاء cart
      final cart = CartModel(items: [cartItem]);

      // إرسال الطلب
      final response = await apiService.post('/cart/add', cart.toJson());

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
