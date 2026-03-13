class EndPoints {
  EndPoints._();

  static const String baseUrl = 'https://demo.onlineezzy.com/wp-json';
  static const String userLogin = '/jwt-auth/v1/token';

  // WooCommerce
  static const String products = '/wc/v3/products';
  static const String cartItems = '/wc/store/v1/cart/items';
  static const String cart = '/wc/store/v1/cart';
  static const String checkout = '/wc/store/v1/checkout';
}
