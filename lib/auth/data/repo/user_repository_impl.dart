import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../core/networkchecker/network_info.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entites/user.dart';
import '../../domain/repo/user_repository.dart';
import '../local/user_local_data_source.dart';
import '../remote/firebase_auth_remote_data_source.dart';

typedef _DataSourceChooser = Future Function();

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> signIn(params) async {
    return await _authenticate(() {
       return remoteDataSource.login(params);
    });
  }

  @override
  Future<Either<Failure, User>> signUp(params) async {
    return await _authenticate(() {
      return remoteDataSource.signUp(params);
    });
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> signOut() async {
    try {
      await localDataSource.clearCache();
      return Right(NoParams());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, User>> _authenticate(
      _DataSourceChooser getDataSource,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await getDataSource();
        // localDataSource.saveToken(remoteResponse.token);
        // localDataSource.saveUser(remoteResponse.user);
        return Right(User(id: '', firstName: '', lastName: '', email: ''));
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

}
