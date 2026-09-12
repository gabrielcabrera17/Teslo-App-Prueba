
import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/errors/product_errors.dart';
import 'package:teslo_shop/features/products/infrastructure/mappers/product_mapper.dart';

class ProductDatasourceImpl extends ProductsDatasource{

  late final Dio dio;
  final String accesToken;

  ProductDatasourceImpl({ 
    required this.accesToken
    }): dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Authorization':'Bearer $accesToken'
        }
      )
    );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductsById(String id) async {
    try{

      final response = await dio.get('/produtcs/$id');
      final product = ProductMapper.jsonToEntity(response.data);
      return product;

    } on DioException catch (e){
      if(e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();
    }
    catch(e){
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for (var product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }

}