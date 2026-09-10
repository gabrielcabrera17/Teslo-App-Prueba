import 'package:flutter_riverpod/legacy.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';


final Provider = StateNotifierProvider.autoDispose.family<ProductNotifier, ProducState, String>(
    (ref, productId) {
    
    final productsRepository = ref.watch(productsRepositoryProvider);

    return ProductNotifier(
      productsRepository: productsRepository, 
      productId: productId
    );
});

class ProductNotifier extends StateNotifier<ProducState> {

  final ProductsRepository productsRepository;
    
  ProductNotifier({
    required this.productsRepository,
    required String productId
  }): super(ProducState(id: productId));

  Future<void> loadProduct() async {

  }  

}

class ProducState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProducState({
    required this.id, 
    this.product, 
    this.isLoading = true, 
    this.isSaving = false
  });

  ProducState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving

  }) => ProducState(
    id: id ?? this.id,
    product: product ?? this.product,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving
  );
   
}