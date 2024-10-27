import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _usecase;
  LoginCubit({required LoginUsecase usecase})
      : _usecase = usecase,
        super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      final result = await _usecase.login(email, password);
      emit(LoginSuccess(login: result));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
