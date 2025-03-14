import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entites/category.dart';
import '../../repo/category_repository.dart';

class GetCachedCategoryUseCase implements UseCase<List<Category>, NoParams> {
  final CategoryRepository repository;
  GetCachedCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getCachedCategories();
  }
}
