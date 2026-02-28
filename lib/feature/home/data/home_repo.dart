import 'package:dio/dio.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/network/api_exceptions.dart';
import 'package:hungryapp/core/network/api_service.dart';
import 'package:hungryapp/feature/home/data/category_model.dart';
import 'package:hungryapp/feature/home/data/product_model.dart';

class HomeRepo {
ApiService apiService =ApiService();
///get products
Future<List<ProductModel>> getProducts()async{
try {
  final Response = await apiService.get("/products");
   final List productsList = Response['data'];
      return productsList
          .map((product) => ProductModel.fromJson(product))
          .toList();
          
} on DioError catch(e) {
    throw ApiExceptions.handleError(e);
  }catch(e){
    throw ApiError(message: e.toString());
  }
}

///get Category
Future<List<CategoryModel>> getCategories()async{
try {
  final Response = await apiService.get("/categories");
   final List categoriesList = Response['data'];
      return categoriesList
          .map((category) => CategoryModel.fromJson(category))
          .toList();
          
} on DioError catch(e) {
    throw ApiExceptions.handleError(e);
  }catch(e){
    throw ApiError(message: e.toString());
  }
}

}
