//Su fin es, poder establecer la instancia de mi product_repository_impl, es decir, permitirle a toda la aplicación poder acceder a ese repositorio

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

import '../../infrastructure/datasource/product_datasource_impl.dart';
import '../../infrastructure/respositories/products_repository_impl.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {

  final accesToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    ProductDatasourceImpl(accesToken: accesToken)
  );

  return productsRepository;
  
});