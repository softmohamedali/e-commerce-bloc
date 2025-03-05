import '../auth/data/remote/firebase_auth_remote_data_source.dart';
import '../auth/presentation/screens/login/cubit/signin_bloc.dart';
import '../auth/presentation/screens/signup/cubit/signup_bloc.dart';
import '../auth/data/local/user_local_data_source.dart';
import '../auth/data/repo/user_repository_impl.dart';
import '../auth/domain/repo/user_repository.dart';
import '../auth/domain/usecase/get_cached_user_usecase.dart';
import '../auth/domain/usecase/sign_in_usecase.dart';
import '../auth/domain/usecase/sign_out_usecase.dart';
import '../auth/domain/usecase/sign_up_usecase.dart';
import 'di.dart';

void registerUserFeature() {
  sl.registerFactory(() => SignInBloc(sl(), sl(), sl()));
  sl.registerFactory(() => SingUpBloc(sl(), sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
        () => FirebaseAuthRemoteDataSource(),
  );
}
