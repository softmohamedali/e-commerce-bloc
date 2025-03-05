import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/product_response_model.dart';
import '../../repo/product_repository.dart';
import '../../../data/models/filter_params_model.dart';

class GetProductUseCase
    implements UseCase<ProductResponseModel, FilterProductParams> {
  final ProductRepository repository;
  GetProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductResponseModel>> call(
      FilterProductParams params) async {
    return await repository.getProducts(params);
  }
}

