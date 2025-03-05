import 'package:dartz/dartz.dart';

import '../../domain/repo/product_repository.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/networkchecker/network_info.dart';
import '../local/product_local_data_source.dart';
import '../remote/product_remote_data_source.dart';
import '../models/filter_params_model.dart';
import '../models/product_response_model.dart';

typedef _ConcreteOrProductChooser = Future<ProductResponseModel> Function();

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductResponseModel>> getProducts(
      FilterProductParams params) async {
    return await _getProduct(() {
      return remoteDataSource.getProducts(params);
    });
  }

  Future<Either<Failure, ProductResponseModel>> _getProduct(
    _ConcreteOrProductChooser getConcreteOrProducts,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await getConcreteOrProducts();
        localDataSource.saveProducts(remoteProducts as ProductResponseModel);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ProductResponseModel>> getProductsCategory(String category) async{
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProductsCategory(category);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }


}
