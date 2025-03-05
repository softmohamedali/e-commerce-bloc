import 'dart:convert';

import '../../domain/entites/category.dart';

List<CategoryModel> categoryModelListFromRemoteJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

List<CategoryModel> categoryModelListFromLocalJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelListToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel extends Category {
  const CategoryModel({
    required String slug,
    required String name,
    required String url,
  }) : super(
          slug: slug,
          name: name,
          url: url,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
      };

  factory CategoryModel.fromEntity(Category entity) => CategoryModel(
        slug: entity.slug,
        name: entity.name,
        url: entity.url,
      );
}
