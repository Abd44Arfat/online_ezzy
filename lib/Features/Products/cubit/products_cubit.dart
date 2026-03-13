import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ezzy/core/utils/networking/failure.dart';
import 'package:online_ezzy/repo/product_repo.dart';

import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.repo) : super(ProductsInitial());

  final ProductRepository repo;

  Future<void> loadProducts({
    int perPage = 10,
    int page = 1,
  }) async {
    emit(ProductsLoading());
    try {
      final products = await repo.fetchProducts(perPage: perPage, page: page);
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsFailure(e is Failure ? e.message : e.toString()));
    }
  }
}

