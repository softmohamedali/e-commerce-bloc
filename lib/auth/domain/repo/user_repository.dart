import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entites/signup_pargms.dart';
import '../entites/user.dart';
import '../usecase/sign_in_usecase.dart';
import '../usecase/sign_up_usecase.dart';


abstract class UserRepository {
  Future<Either<Failure, User>> signIn(SignInParams params);
  Future<Either<Failure, User>> signUp(SignUpParams params);
  Future<Either<Failure, NoParams>> signOut();
  Future<Either<Failure, User>> getCachedUser();
}
