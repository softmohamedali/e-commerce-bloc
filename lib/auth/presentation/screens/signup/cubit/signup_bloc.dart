import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/cupertino.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/entites/signup_pargms.dart';
import '../../../../domain/entites/user.dart';
import '../../../../domain/usecase/get_cached_user_usecase.dart';
import '../../../../domain/usecase/sign_in_usecase.dart';
import '../../../../domain/usecase/sign_out_usecase.dart';
import '../../../../domain/usecase/sign_up_usecase.dart';
import '../../login/cubit/signin_bloc.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SingUpBloc extends Bloc<SignupEvent, SignupState> {
  final GetCachedUserUseCase _getCachedUserUseCase;
  final SignUpUseCase _signUpUseCase;
  SingUpBloc(
      this._getCachedUserUseCase,
      this._signUpUseCase,
      ) : super(UserInitial()) {
    on<SignUpUser>(_onSignUp);
    on<CheckSignUpUser>(_onCheckUser);
  }


  void _onCheckUser(CheckSignUpUser event, Emitter<SignupState> emit) async {
    try {
      emit(UserSignUpLoading());
      final result = await _getCachedUserUseCase(NoParams());
      result.fold(
            (failure) => emit(UserSignUpFail(failure)),
            (user) => emit(UserSignUp(user)),
      );
    } catch (e) {
      emit(UserSignUpFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUp(SignUpUser event, Emitter<SignupState> emit) async {
    try {
      emit(UserSignUpLoading());
      final result = await _signUpUseCase(event.params);
      result.fold(
            (failure) => emit(UserSignUpFail(failure)),
            (user) => emit(UserSignUp(user)),
      );
    } catch (e,s) {
      print("error $e  -- $s");
      emit(UserSignUpFail(ExceptionFailure()));
    }
  }

}
