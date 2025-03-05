part of 'signin_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInUser extends SignInEvent {
  final SignInParams params;
  SignInUser(this.params);
}


class SignOutUser extends SignInEvent {}

class CheckUser extends SignInEvent {}
