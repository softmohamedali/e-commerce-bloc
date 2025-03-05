import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entites/signup_pargms.dart';
import '../entites/user.dart';
import '../repo/user_repository.dart';

class SignUpUseCase implements UseCase<User, SignUpParams> {
  final UserRepository repository;
  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(params);
  }
}


