import 'package:online_ezzy/data/Models/cart/cart_item_model.dart';

sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  CartSuccess(this.items);
  final List<CartItemModel> items;
}

class CartFailure extends CartState {
  CartFailure(this.message);
  final String message;
}

