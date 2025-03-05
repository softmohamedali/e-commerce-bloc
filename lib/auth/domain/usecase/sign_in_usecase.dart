import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entites/user.dart';
import '../repo/user_repository.dart';

class SignInUseCase implements UseCase<User, SignInParams> {
  final UserRepository repository;
  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(params);
  }
}

class SignInParams {
  final String email;
  final String password;
  const SignInParams({
    required this.email,
    required this.password,
  });
}