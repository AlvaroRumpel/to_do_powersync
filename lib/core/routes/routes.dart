import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/login/domain/usecases/login_usecase.dart';
import '../../features/login/presentation/bloc/login_cubit.dart';
import '../../features/login/presentation/page/login_page.dart';
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
          routes: [
            GoRoute(
              path: LOGIN,
              builder: (context, state) {
                return BlocProvider(
                  create: (ctx) => LoginCubit(usecase: getIt<LoginUsecase>()),
                  child: const LoginPage(),
                );
              },
            ),
          ],
        );
}
