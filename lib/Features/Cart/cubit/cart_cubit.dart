import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:online_ezzy/repo/cart_repo.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.repo) : super(CartInitial());

  final CartRepository repo;

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final items = await repo.listItems();
      emit(CartSuccess(items));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  String _msg(Object e) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) return data['message'].toString();
      return e.message ?? e.toString();
    }
    return e.toString();
  }

  Future<void> addItem(
    int productId,
    int quantity, {
    Map<String, String>? variation,
  }) async {
    try {
      final items = await repo.addItem(
        productId,
        quantity,
        variation: variation,
      );
      emit(CartSuccess(items));
    } catch (e) {
      emit(CartFailure(_msg(e)));
    }
  }

  Future<void> updateQuantity(String key, int quantity) async {
    try {
      final items = await repo.updateQuantity(key, quantity);
      emit(CartSuccess(items));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> removeItem(String key) async {
    try {
      final items = await repo.removeItem(key);
      emit(CartSuccess(items));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    try {
      await repo.clearCart();
      final items = await repo.listItems();
      emit(CartSuccess(items));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<String?> checkout({
    required Map<String, dynamic> billingAddress,
    Map<String, dynamic>? shippingAddress,
    required String paymentMethod,
    required List<Map<String, dynamic>> paymentData,
    bool createAccount = false,
    String? password,
  }) async {
    try {
      await repo.checkout(
        billingAddress: billingAddress,
        shippingAddress: shippingAddress,
        paymentMethod: paymentMethod,
        paymentData: paymentData,
        createAccount: createAccount,
        password: password,
      );
      // Refresh cart after successful checkout (likely becomes empty).
      await loadCart();
      return null;
    } catch (e) {
      final msg = _msg(e);
      emit(CartFailure(msg));
      return msg;
    }
  }
}

