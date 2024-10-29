import '../entities/to_do.dart';

abstract interface class HomeRepository {
  Future<void> createToDo(ToDo toDo);
  Future<List<ToDo>> fetchToDos();
}
