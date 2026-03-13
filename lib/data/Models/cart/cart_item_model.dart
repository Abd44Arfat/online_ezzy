class CartItemModel {
  const CartItemModel({
    required this.key,
    required this.name,
    required this.quantity,
    required this.price,
    this.imageUrl,
  });

  final String key;
  final String name;
  final int quantity;
  final String price;
  final String? imageUrl;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final images = json['images'];
    String? img;
    if (images is List && images.isNotEmpty) {
      final first = images.first;
      if (first is Map && first['src'] is String) {
        img = first['src'] as String;
      }
    }
    return CartItemModel(
      key: (json['key'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      price: ((json['prices']?['price'] ?? '')).toString(),
      imageUrl: img,
    );
  }
}

