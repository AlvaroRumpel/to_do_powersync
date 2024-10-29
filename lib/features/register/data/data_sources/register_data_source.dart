import '../../../../shared/entities/user.dart';

abstract interface class RegisterDataSource {
  Future<User> createAccount(String email, String password);
}
