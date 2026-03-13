import 'package:dio/dio.dart';
import 'package:online_ezzy/core/utils/networking/api_constants.dart';
import 'package:online_ezzy/core/utils/networking/dio_helper.dart';
import 'package:online_ezzy/data/Models/cart/cart_item_model.dart';
import 'package:online_ezzy/data/Models/cart/cart_totals_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  CartRepository(this.api);

  final DioClient api;

  static const _prefsCartTokenKey = 'cart_token';

  Future<String?> _getCartToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_prefsCartTokenKey);
    // Debug: print stored cart token
    // ignore: avoid_print
    print('🛒 Stored Cart-Token: $token');
    return token;
  }

  Future<void> _saveCartTokenFromResponse(Response response) async {
    final token = response.headers['cart-token']?.first ??
        response.headers['Cart-Token']?.first ??
        response.headers.value('cart-token') ??
        response.headers.value('Cart-Token');
    if (token != null && token.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsCartTokenKey, token);
      // Debug: print token received from API
      // ignore: avoid_print
      print('🛒 Saved Cart-Token from response: $token');
    }
  }

  Future<List<CartItemModel>> listItems() async {
    final token = await _getCartToken();
    final response = await api.get(
      EndPoints.cartItems,
      options: Options(
        headers: token == null ? {} : {'Cart-Token': token},
      ),
    );
    await _saveCartTokenFromResponse(response);

    final data = response.data;
    if (data is List) {
      return data
          .whereType<Map>()
          .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  Future<CartTotalsModel> getCartTotals() async {
    final token = await _getCartToken();
    final response = await api.get(
      EndPoints.cart,
      options: Options(
        headers: token == null ? {} : {'Cart-Token': token},
      ),
    );
    await _saveCartTokenFromResponse(response);

    final data = response.data;
    if (data is Map) {
      return CartTotalsModel.fromCartJson(Map<String, dynamic>.from(data));
    }
    return const CartTotalsModel(
      currencyCode: '',
      currencySymbol: '',
      totalPrice: '',
      totalTax: '',
      totalShipping: '',
      totalItems: 0,
    );
  }

  Future<List<CartItemModel>> addItem(
    int productId,
    int quantity, {
    Map<String, String>? variation,
  }) async {
    final token = await _getCartToken();
    final queryParams = <String, dynamic>{
      'id': productId.toString(),
      'quantity': quantity.toString(),
    };

    // Match Postman style: variation[attribute_x]=value as query params.
    if (variation != null && variation.isNotEmpty) {
      variation.forEach((key, value) {
        queryParams['variation[$key]'] = value;
      });
    }

    final response = await api.post(
      EndPoints.cartItems,
      queryParameters: queryParams,
      options: Options(
        headers: {
          if (token != null && token.isNotEmpty) 'Cart-Token': token,
        },
      ),
    );
    await _saveCartTokenFromResponse(response);
    return listItems();
  }

  Future<Response> checkout({
    required Map<String, dynamic> billingAddress,
    Map<String, dynamic>? shippingAddress,
    required String paymentMethod,
    required List<Map<String, dynamic>> paymentData,
    bool createAccount = false,
    String? password,
  }) async {
    final token = await _getCartToken();

    final Map<String, dynamic> body = {
      'billing_address': billingAddress,
      if (shippingAddress != null) 'shipping_address': shippingAddress,
      'payment_method': paymentMethod,
      'payment_data': paymentData,
    };

    // Match your working Postman request:
    // - When creating an account, the store expects `password`.
    // Also keep compatibility with Store API docs (`customer_password`) by sending both.
    if (createAccount && password != null && password.isNotEmpty) {
      body['password'] = password; // legacy / store-specific
      body['customer_password'] = password; // Store API docs
    }

    final response = await api.post(
      EndPoints.checkout,
      data: body,
      options: Options(
        headers: {
          if (token != null && token.isNotEmpty) 'Cart-Token': token,
          'Content-Type': 'application/json',
        },
      ),
    );

    await _saveCartTokenFromResponse(response);
    return response;
  }

  Future<List<CartItemModel>> updateQuantity(String itemKey, int quantity) async {
    final token = await _getCartToken();
    final response = await api.put(
      '${EndPoints.cartItems}/$itemKey',
      queryParameters: {'quantity': quantity.toString()},
      options: Options(
        headers: token == null ? {} : {'Cart-Token': token},
      ),
    );
    await _saveCartTokenFromResponse(response);
    return listItems();
  }

  Future<List<CartItemModel>> removeItem(String itemKey) async {
    final token = await _getCartToken();
    await api.delete(
      '${EndPoints.cartItems}/$itemKey',
      options: Options(
        headers: token == null ? {} : {'Cart-Token': token},
      ),
    );
    return listItems();
  }

  Future<void> clearCart() async {
    final token = await _getCartToken();
    await api.delete(
      EndPoints.cartItems,
      options: Options(
        headers: token == null ? {} : {'Cart-Token': token},
      ),
    );
  }
}

