class VariationAttribute {
  const VariationAttribute({
    required this.name,
    required this.option,
  });

  final String name;
  final String option;

  factory VariationAttribute.fromJson(Map<String, dynamic> json) {
    return VariationAttribute(
      name: (json['name'] ?? '').toString(),
      option: (json['option'] ?? '').toString(),
    );
  }
}

class ProductVariationModel {
  const ProductVariationModel({
    required this.id,
    required this.purchasable,
    required this.inStock,
    required this.attributes,
  });

  final int id;
  final bool purchasable;
  final bool inStock;
  final List<VariationAttribute> attributes;

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      purchasable: (json['purchasable'] as bool?) ?? true,
      inStock: ((json['stock_status'] ?? '') == 'instock'),
      attributes: (json['attributes'] as List?)
              ?.whereType<Map>()
              .map((e) =>
                  VariationAttribute.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          const <VariationAttribute>[],
    );
  }
}

