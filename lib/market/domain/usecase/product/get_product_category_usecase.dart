import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/product_response_model.dart';
import '../../repo/product_repository.dart';
import '../../../data/models/filter_params_model.dart';

class GetProductCategoryUseCase
    implements UseCase<ProductResponseModel, String> {
  final ProductRepository repository;
  GetProductCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, ProductResponseModel>> call(String category) async {
    return await repository.getProductsCategory(category);
  }
}

