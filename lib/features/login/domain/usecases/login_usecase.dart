import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository _repo;

  const LoginUsecase({required LoginRepository repo}) : _repo = repo;

  Future<User> login(String email, String password) async {
    try {
      return await _repo.login(email, password);
    } catch (e) {
      throw Exception();
    }
  }
}
