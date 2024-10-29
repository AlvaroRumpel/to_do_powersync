import '../models/to_do_model.dart';

abstract interface class HomeDataSource {
  Future<void> createToDo(ToDoModel toDo);
  Future<List<ToDoModel>> fetchToDos();
}
