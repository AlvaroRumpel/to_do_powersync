import 'package:get_it/get_it.dart';

import '../../features/login/data/data_sources/login_data_source.dart';
import '../../features/login/data/data_sources/login_data_source_impl.dart';
import '../../features/login/data/repositories/login_repository_impl.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/login_usecase.dart';
import '../../shared/services/backend/backend.dart';
import '../../shared/services/sync/sync.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Backend>(Backend());
  getIt.registerSingleton<Sync>(Sync(backend: getIt()));
  registerLogin();
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
