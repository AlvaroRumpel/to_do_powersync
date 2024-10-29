import '../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../shared/services/backend/backend.dart';
import '../entities/to_do.dart';
import '../repositories/home_repository.dart';

class HomeUsecase {
  final HomeRepository _repo;

  HomeUsecase({required HomeRepository repo}) : _repo = repo;

  Future<void> createToDo(String task) async {
    final userId = getIt<Backend>().userId;

    if (userId == null) {
      throw Exception();
    }

    final toDo = ToDo(task: task, userId: userId);

    return await _repo.createToDo(toDo);
  }

  Future<List<ToDo>> fetchToDos() async {
    return await _repo.fetchToDos();
  }
}
