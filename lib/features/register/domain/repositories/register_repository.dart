import '../../../../shared/entities/user.dart';

abstract interface class RegisterRepository {
  Future<User> createAccount(String email, String password);
}
