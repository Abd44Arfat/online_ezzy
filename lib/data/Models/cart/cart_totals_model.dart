class CartTotalsModel {
  const CartTotalsModel({
    required this.currencyCode,
    required this.currencySymbol,
    required this.totalPrice,
    required this.totalTax,
    required this.totalShipping,
    required this.totalItems,
  });

  final String currencyCode;
  final String currencySymbol;
  final String totalPrice;
  final String totalTax;
  final String totalShipping;
  final int totalItems;

  String get formattedTotal {
    // totalPrice is in minor units as a string (e.g. "13000" with minor_unit 2 -> 130.00)
    if (totalPrice.isEmpty) return '';
    return '$currencySymbol $totalPrice';
  }

  factory CartTotalsModel.fromCartJson(Map<String, dynamic> json) {
    final totals = (json['totals'] is Map)
        ? Map<String, dynamic>.from(json['totals'] as Map)
        : <String, dynamic>{};

    return CartTotalsModel(
      currencyCode: (totals['currency_code'] ?? '').toString(),
      currencySymbol: (totals['currency_symbol'] ?? '').toString(),
      totalPrice: (totals['total_price'] ?? totals['total'] ?? '').toString(),
      totalTax: (totals['total_tax'] ?? '').toString(),
      totalShipping: (totals['total_shipping'] ?? '').toString(),
      totalItems: (json['items_count'] as num?)?.toInt() ?? 0,
    );
  }
}

