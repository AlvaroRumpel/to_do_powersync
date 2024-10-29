import '../../../../shared/entities/user.dart';
import '../repositories/register_repository.dart';

class RegisterUsecase {
  final RegisterRepository _repo;

  RegisterUsecase({required RegisterRepository repo}) : _repo = repo;

  Future<User> createAccount(String email, String password) async {
    return await _repo.createAccount(email, password);
  }
}
