// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../domain/usecases/login_usecase.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final LoginUsecase _usecase;

//   LoginBloc({required LoginUsecase usecase})
//       : _usecase = usecase,
//         super(LoginInitial()) {
//     on<LoginRequested>(_onLoginRequested);
//   }

//   Future<void> _onLoginRequested(
//       LoginRequested event, Emitter<LoginState> emit) async {
//     emit(LoginLoading());
//     try {
//       final result = await _usecase.login(event.email, event.password);
//       emit(LoginSuccess(login: result));
//     } catch (e) {
//       emit(LoginError(message: e.toString()));
//     }
//   }
// }
