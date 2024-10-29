part of 'register_cubit.dart';

@immutable
sealed class RegisterState extends Equatable {
  const RegisterState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function() success,
    required T Function(String message) error,
  }) {
    if (this is RegisterInitial) {
      return initial();
    } else if (this is RegisterLoading) {
      return loading();
    } else if (this is RegisterSuccess) {
      return success();
    } else if (this is RegisterError) {
      return error((this as RegisterError).message);
    }
    throw Exception('Unreachable');
  }

  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function()? success,
    T Function(String message)? error,
    required T? Function() orElse,
  }) {
    if (this is RegisterInitial && initial != null) {
      return initial();
    } else if (this is RegisterLoading && loading != null) {
      return loading();
    } else if (this is RegisterSuccess && success != null) {
      return success();
    } else if (this is RegisterError && error != null) {
      return error((this as RegisterError).message);
    } else {
      return orElse();
    }
  }

  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? loading,
    T Function()? success,
    T Function(String message)? error,
  }) {
    return maybeWhen(
      initial: initial,
      loading: loading,
      success: success,
      error: error,
      orElse: () => null,
    );
  }

  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

final class RegisterError extends RegisterState {
  final String message;

  const RegisterError({required this.message});

  @override
  List<Object?> get props => [message];
}
