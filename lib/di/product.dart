import '../market/domain/usecase/product/get_product_category_usecase.dart';
import '../market/presentation/screens/product_list/product_bloc.dart';
import '../market/data/local/product_local_data_source.dart';
import '../market/data/remote/product_remote_data_source.dart';
import '../market/data/repo/product_repository_impl.dart';
import '../market/domain/repo/product_repository.dart';
import '../market/domain/usecase/product/get_product_usecase.dart';
import 'di.dart';

void registerProductFeature() {
  sl.registerFactory(() => ProductBloc(sl(),sl()));
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  sl.registerLazySingleton(() => GetProductCategoryUseCase(sl()));

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
        () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );
}