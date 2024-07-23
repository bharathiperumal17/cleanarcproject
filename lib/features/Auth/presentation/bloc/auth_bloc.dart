import 'dart:async';

import 'package:cleanarcproject/core/common/widget/cubit/app_user_cubit/appuser_cubit.dart';
import 'package:cleanarcproject/core/user.dart';
import 'package:cleanarcproject/features/Auth/domain/usercases/user_sign_in.dart';
import 'package:cleanarcproject/features/Auth/domain/usercases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final AppuserCubit _appuserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required AppuserCubit appuserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _appuserCubit = appuserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(authSignUp);
    on<AuthSignIn>(authSignIn);
  }

  FutureOr<void> authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(UserSignUpParams(
        email: event.email, name: event.name, password: event.password));
    response.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => _emitAuthSuces(user, emit));
  }

  FutureOr<void> authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final response = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password));
    response.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => _emitAuthSuces(user, emit));
  }

  void _emitAuthSuces(User user, Emitter<AuthState> emit) {
    _appuserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
