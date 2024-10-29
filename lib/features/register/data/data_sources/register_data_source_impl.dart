import '../../../../shared/entities/user.dart';
import '../../../../shared/services/backend/backend.dart';
import 'register_data_source.dart';

class RegisterDataSourceImpl implements RegisterDataSource {
  final Backend _backend;

  RegisterDataSourceImpl({required Backend backend}) : _backend = backend;
  @override
  Future<User> createAccount(String email, String password) async {
    try {
      final response = await _backend.signUp(email, password);
      if (response?.user != null) {
        final user = User(
          id: response?.user?.id,
          email: response?.user?.email ?? email,
          createdAt: DateTime.tryParse(response?.user?.createdAt ?? ''),
        );
        await _backend.insertData(userTable, user.toMap());

        return user;
      }

      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
