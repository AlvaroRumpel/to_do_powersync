import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../shared/services/backend/backend.dart';
import 'login_data_source.dart';

class LoginDataSourceImpl implements LoginDataSource {
  final Backend _backend;

  LoginDataSourceImpl({required Backend backend}) : _backend = backend;
  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _backend.signIn(email, password);
      if (response != null) {
        return response.user!;
      }
      throw Exception('');
    } catch (e) {
      rethrow;
    }
  }
}
