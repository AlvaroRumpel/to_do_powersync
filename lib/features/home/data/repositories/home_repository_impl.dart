import '../../domain/entities/to_do.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_data_source.dart';
import '../models/to_do_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _dataSource;

  HomeRepositoryImpl({required HomeDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<void> createToDo(ToDo toDo) async {
    final model = ToDoModel.fromEntity(toDo);
    return await _dataSource.createToDo(model);
  }

  @override
  Future<List<ToDo>> fetchToDos() async {
    final toDos = await _dataSource.fetchToDos();

    final entities = <ToDo>[];

    for (final item in toDos) {
      entities.add(ToDo.fromModel(item));
    }

    return entities;
  }
}
