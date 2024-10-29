import '../../../../shared/services/sync/simple_orm.dart';
import '../../../../shared/services/sync/sync.dart';
import '../models/to_do_model.dart';
import 'home_data_source.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final Sync _sync;
  final SimpleORM _database;

  HomeDataSourceImpl({required Sync sync})
      : _sync = sync,
        _database = SimpleORM(sync: sync, tableName: toDoTable);
  @override
  Future<void> createToDo(ToDoModel task) async {
    try {
      await _database.insert(
        fieldsAndValue: task.toDB(),
        parameters: [task.task, task.userId],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ToDoModel>> fetchToDos() async {
    try {
      final response = await _database.fetch(
        filter: {'user_id': _sync.userId},
      );

      if (response.isEmpty) {
        return [];
      }

      final toDos = <ToDoModel>[];
      for (final item in response) {
        toDos.add(ToDoModel.fromMap(item));
      }
      return toDos;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
