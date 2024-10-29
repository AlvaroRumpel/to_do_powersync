import 'package:powersync/powersync.dart';

import 'sync.dart';

class SimpleORM {
  final Sync _sync;
  final String _tableName;

  SimpleORM({required Sync sync, required String tableName})
      : _tableName = tableName,
        _sync = sync;

  PowerSyncDatabase get _db => _sync.db;

  Future<List<Map<String, dynamic>>> fetch({
    Map<String, dynamic>? filter,
  }) async {
    try {
      final query = StringBuffer('SELECT * FROM $_tableName');
      final parameters = <Object?>[];

      if (filter != null && filter.isNotEmpty) {
        query.write(' WHERE');
        filter.forEach((key, value) {
          query.write(' $key = ?');
          parameters.add(value);
        });
      }

      final result = await _db.getAll(query.toString(), parameters);

      if (result.firstOrNull != null) {
        return result;
      }

      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> insert({
    required Map<String, String> fieldsAndValue,
    required List<Object?> parameters,
  }) async {
    try {
      final fields = StringBuffer('(${fieldsAndValue.keys.join(', ')})');
      final values = StringBuffer('(${fieldsAndValue.values.join(', ')})');

      final result = await _db.execute(
        '''
      INSERT INTO
        $_tableName$fields
        VALUES$values
      RETURNING *
      ''',
        parameters,
      );

      if (result.firstOrNull == null) {
        throw Exception();
      }

      return result.first;
    } catch (e) {
      rethrow;
    }
  }
}
