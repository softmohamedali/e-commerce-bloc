import 'dart:convert';

import 'package:ecommerce/market/data/models/product_model.dart';

ProductResponseModel productResponseModelFromJson(String str)=>
    ProductResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductResponseModel data) => json.encode(data.toJson());

class ProductResponseModel {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  ProductResponseModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      products: (json['products'] as List).map((e) => ProductModel.fromJson(e)).toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}