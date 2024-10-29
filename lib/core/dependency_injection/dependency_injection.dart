import 'package:get_it/get_it.dart';

import '../../features/home/data/data_sources/home_data_source.dart';
import '../../features/home/data/data_sources/home_data_source_impl.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/home_usecase.dart';
import '../../features/login/data/data_sources/login_data_source.dart';
import '../../features/login/data/data_sources/login_data_source_impl.dart';
import '../../features/login/data/repositories/login_repository_impl.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/login_usecase.dart';
import '../../features/register/data/data_sources/register_data_source.dart';
import '../../features/register/data/data_sources/register_data_source_impl.dart';
import '../../features/register/data/repositories/register_repository_impl.dart';
import '../../features/register/domain/repositories/register_repository.dart';
import '../../features/register/domain/usecases/register_usecase.dart';
import '../../shared/services/backend/backend.dart';
import '../../shared/services/sync/sync.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Backend>(Backend());
  getIt.registerSingleton<Sync>(Sync(backend: getIt()));
  registerLogin();
  registerRegister();
  registerHome();
}

void registerLogin() {
  getIt.registerLazySingleton<LoginDataSource>(
    () => LoginDataSourceImpl(backend: getIt()),
  );
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(dataSource: getIt()),
  );
  getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecase(repo: getIt()));
}

void registerRegister() {
  getIt.registerLazySingleton<RegisterDataSource>(
    () => RegisterDataSourceImpl(backend: getIt()),
  );
  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(dataSource: getIt()),
  );
  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(repo: getIt()),
  );
}

void registerHome() {
  getIt.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(sync: getIt()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(dataSource: getIt()),
  );
  getIt.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(repo: getIt()),
  );
}
