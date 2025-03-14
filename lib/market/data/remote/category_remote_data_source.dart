import 'package:http/http.dart' as http;
import '../../../core/constant/api.dart';

import '../../../core/error/failures.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;
  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() =>
      _getCategoryFromUrl('$baseUrl/products/categories');

  Future<List<CategoryModel>> _getCategoryFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return categoryModelListFromRemoteJson(response.body);
    } else {
      throw ServerFailure();
    }
  }
}
