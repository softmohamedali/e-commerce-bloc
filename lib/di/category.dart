import '../market/presentation/screens/categories/category_bloc.dart';
import '../market/data/local/category_local_data_source.dart';
import '../market/data/remote/category_remote_data_source.dart';
import '../market/data/repo/categories_repository_impl.dart';
import '../market/domain/repo/category_repository.dart';
import '../market/domain/usecase/category/filter_category_usecase.dart';
import '../market/domain/usecase/category/get_cached_category_usecase.dart';
import '../market/domain/usecase/category/get_remote_category_usecase.dart';
import 'di.dart';

void registerCategoryFeature() {
  sl.registerFactory(() => CategoryBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetRemoteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterCategoryUseCase(sl()));

  sl.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
        () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
  );
}