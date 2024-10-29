import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/login_repository.dart';
import '../data_sources/login_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _dataSource;

  LoginRepositoryImpl({required LoginDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<User> login(String email, String password) async {
    return await _dataSource.login(email, password);
  }
}
