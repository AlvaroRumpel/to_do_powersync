import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class LoginDataSource {
  Future<User> login(String email, String password);
}
