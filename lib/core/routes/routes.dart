import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/domain/usecases/home_usecase.dart';
import '../../features/home/presentation/bloc/home_cubit.dart';
import '../../features/home/presentation/page/home_page.dart';
import '../../features/login/domain/usecases/login_usecase.dart';
import '../../features/login/presentation/bloc/login_cubit.dart';
import '../../features/login/presentation/page/login_page.dart';
import '../../features/register/domain/usecases/register_usecase.dart';
import '../../features/register/presentation/bloc/register_cubit.dart';
import '../../features/register/presentation/page/register_page.dart';
import '../../shared/services/backend/backend.dart';
import '../dependency_injection/dependency_injection.dart';

part 'routes_names.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          initialLocation: LOGIN,
          // errorBuilder: (context, state) => ErrorPage(
          //   message: state.error?.toString() ?? 'Unknown error',
          // ),
          redirect: (context, state) {
            final backend = getIt<Backend>();
            if (state.fullPath != LOGIN &&
                state.fullPath != REGISTER &&
                !backend.isLogged) {
              return LOGIN;
            }

            if ((state.fullPath == LOGIN || state.fullPath == REGISTER) &&
                backend.isLogged) {
              return HOME;
            }

            return null;
          },
          routes: [
            GoRoute(
              path: LOGIN,
              name: LOGIN,
              builder: (context, state) {
                return BlocProvider(
                  create: (ctx) => LoginCubit(usecase: getIt<LoginUsecase>()),
                  child: const LoginPage(),
                );
              },
            ),
            GoRoute(
              path: REGISTER,
              name: REGISTER,
              builder: (context, state) => BlocProvider(
                create: (context) => RegisterCubit(
                  usecase: getIt<RegisterUsecase>(),
                ),
                child: const RegisterPage(),
              ),
            ),
            GoRoute(
              path: HOME,
              name: HOME,
              builder: (context, state) {
                return BlocProvider(
                  create: (ctx) => HomeCubit(usecase: getIt<HomeUsecase>()),
                  child: const HomePage(),
                );
              },
            )
          ],
        );
}
