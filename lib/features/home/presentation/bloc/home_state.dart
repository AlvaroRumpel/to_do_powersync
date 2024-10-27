part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(Home home) success,
    required T Function(String message) error,
  }) {
    if (this is HomeInitial) {
      return initial();
    } else if (this is HomeLoading) {
      return loading();
    } else if (this is HomeSuccess) {
      return success((this as HomeSuccess).home);
    } else if (this is HomeError) {
      return error((this as HomeError).message);
    }
    throw Exception('Unreachable');
  }

  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(Home home)? success,
    T Function(String message)? error,
    required T? Function() orElse,
  }) {
    if (this is HomeInitial && initial != null) {
      return initial();
    } else if (this is HomeLoading && loading != null) {
      return loading();
    } else if (this is HomeSuccess && success != null) {
      return success((this as HomeSuccess).home);
    } else if (this is HomeError && error != null) {
      return error((this as HomeError).message);
    } else {
      return orElse();
    }
  }

  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(Home home)? success,
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

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final Home home;

  const HomeSuccess({required this.home});

  @override
  List<Object?> get props => [home];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
