part of 'signin_bloc.dart';

@immutable
abstract class SignInState extends Equatable {}

class UserInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class UserLoading extends SignInState {
  @override
  List<Object> get props => [];
}

class UserLogged extends SignInState {
  final User user;
  UserLogged(this.user);
  @override
  List<Object> get props => [user];
}

class UserLoggedFail extends SignInState {
  final Failure failure;
  UserLoggedFail(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserLoggedOut extends SignInState {
  @override
  List<Object> get props => [];
}
