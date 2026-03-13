class ProductImage {
  const ProductImage({required this.src});

  final String src;

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(src: (json['src'] as String?) ?? '');
  }
}

class ProductAttribute {
  const ProductAttribute({
    required this.id,
    required this.name,
    required this.slug,
  });

  final int id;
  final String name;
  final String slug;

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? '').toString(),
      slug: (json['slug'] ?? '').toString(),
    );
  }
}

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.type,
    required this.variations,
    required this.attributes,
    required this.images,
  });

  final int id;
  final String name;
  final String price;
  final String description;
  final String type; // simple / variable ...
  final List<int> variations; // variation IDs if variable
  final List<ProductAttribute> attributes;
  final List<ProductImage> images;

  String? get primaryImage =>
      images.isNotEmpty && images.first.src.isNotEmpty ? images.first.src : null;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final imgs = (json['images'] as List?)
            ?.whereType<Map>()
            .map((e) => ProductImage.fromJson(Map<String, dynamic>.from(e)))
            .toList() ??
        const <ProductImage>[];

    final attrs = (json['attributes'] as List?)
            ?.whereType<Map>()
            .map(
              (e) => ProductAttribute.fromJson(
                Map<String, dynamic>.from(e),
              ),
            )
            .toList() ??
        const <ProductAttribute>[];

    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?) ?? '',
      price: (json['price'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      variations: (json['variations'] as List?)
              ?.whereType<num>()
              .map((e) => e.toInt())
              .toList() ??
          const <int>[],
      attributes: attrs,
      images: imgs,
    );
  }
}

