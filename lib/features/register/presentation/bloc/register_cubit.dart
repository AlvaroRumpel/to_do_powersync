import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _usecase;
  RegisterCubit({required RegisterUsecase usecase})
      : _usecase = usecase,
        super(RegisterInitial());

  Future<void> createAccount(String email, String password) async {
    try {
      emit(RegisterLoading());
      await _usecase.createAccount(email, password);
      emit(const RegisterSuccess());
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }
}
