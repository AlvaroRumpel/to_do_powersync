import '../../../../shared/entities/user.dart';
import '../../domain/repositories/register_repository.dart';
import '../data_sources/register_data_source.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterDataSource _dataSource;

  RegisterRepositoryImpl({required RegisterDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<User> createAccount(String email, String password) async {
    return await _dataSource.createAccount(email, password);
  }
}
