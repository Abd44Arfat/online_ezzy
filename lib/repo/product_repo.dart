import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:online_ezzy/core/utils/networking/api_constants.dart';
import 'package:online_ezzy/core/utils/networking/dio_helper.dart';
import 'package:online_ezzy/core/utils/networking/woocommerce_credentials.dart';
import 'package:online_ezzy/data/Models/products/product_model.dart';
import 'package:online_ezzy/data/Models/products/variation_model.dart';

class ProductRepository {
  ProductRepository(this.api);

  final DioClient api;

  Options _basicAuthOptions() {
    final token = base64Encode(
      utf8.encode('${WooCredentials.consumerKey}:${WooCredentials.consumerSecret}'),
    );
    return Options(
      headers: {
        'Authorization': 'Basic $token',
      },
    );
  }

  Future<List<ProductModel>> fetchProducts({
    int perPage = 10,
    int page = 1,
  }) async {
    final response = await api.get(
      EndPoints.products,
      queryParameters: {
        'per_page': perPage,
        'page': page,
      },
      options: _basicAuthOptions(),
    );

    final data = response.data;
    if (data is List) {
      return data
          .whereType<Map>()
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    return [];
  }

  Future<List<ProductVariationModel>> fetchVariations(int productId) async {
    final response = await api.get(
      '${EndPoints.products}/$productId/variations',
      queryParameters: {'per_page': 50},
      options: _basicAuthOptions(),
    );

    final data = response.data;
    if (data is List) {
      return data
          .whereType<Map>()
          .map((e) =>
              ProductVariationModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }
}

