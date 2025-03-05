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

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GetCachedUserUseCase _getCachedUserUseCase;
  final SignInUseCase _signInUseCase;

  final SignOutUseCase _signOutUseCase;
  SignInBloc(
    this._signInUseCase,
    this._getCachedUserUseCase,
    this._signOutUseCase,
  ) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<CheckUser>(_onCheckUser);
    on<SignOutUser>(_onSignOut);
  }

  void _onSignIn(SignInUser event, Emitter<SignInState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onCheckUser(CheckUser event, Emitter<SignInState> emit) async {
    try {
      emit(UserLoading());
      final result = await _getCachedUserUseCase(NoParams());
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onSignOut(SignOutUser event, Emitter<SignInState> emit) async {
    try {
      emit(UserLoading());
      await _signOutUseCase(NoParams());
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}
