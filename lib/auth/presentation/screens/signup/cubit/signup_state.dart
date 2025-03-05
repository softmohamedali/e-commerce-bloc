part of 'signup_bloc.dart';



@immutable
abstract class SignupState extends Equatable {}

class UserInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class UserSignUpLoading extends SignupState {
  @override
  List<Object> get props => [];
}

class UserSignUp extends SignupState {
  final User user;
  UserSignUp(this.user);
  @override
  List<Object> get props => [user];
}

class UserSignUpFail extends SignupState {
  final Failure failure;
  UserSignUpFail(this.failure);
  @override
  List<Object> get props => [failure];
}
