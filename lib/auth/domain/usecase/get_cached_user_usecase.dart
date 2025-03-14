import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entites/user.dart';
import '../repo/user_repository.dart';

class GetCachedUserUseCase implements UseCase<User, NoParams> {
  final UserRepository repository;
  GetCachedUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCachedUser();
  }
}
