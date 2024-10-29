import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../shared/services/sync/sync.dart';
import '../../domain/entities/to_do.dart';
import '../../domain/usecases/home_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase _usecase;
  HomeCubit({required HomeUsecase usecase})
      : _usecase = usecase,
        super(HomeInitial());

  Future<void> logout() async {
    await getIt<Sync>().logout();
  }

  Future<void> createToDo(String task) async {
    try {
      emit(HomeLoading());
      await _usecase.createToDo(task);
      final toDos = await _usecase.fetchToDos();
      emit(HomeData(toDos: toDos));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
