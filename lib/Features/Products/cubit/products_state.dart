import 'package:online_ezzy/data/Models/products/product_model.dart';

sealed class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  ProductsSuccess(this.products);
  final List<ProductModel> products;
}

class ProductsFailure extends ProductsState {
  ProductsFailure(this.message);
  final String message;
}

