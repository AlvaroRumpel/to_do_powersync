import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class LoginRepository {
  Future<User> login(String email, String password);
}
