part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}


class SignUpUser extends SignupEvent {
  final SignUpParams params;
  SignUpUser(this.params);
}

class CheckSignUpUser extends SignupEvent {}

