import 'package:dartz/dartz.dart';
import '../../data/models/product_response_model.dart';

import '../../../core/error/failures.dart';
import '../../data/models/filter_params_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponseModel>> getProducts(FilterProductParams params);
  Future<Either<Failure, ProductResponseModel>> getProductsCategory(String category);

}