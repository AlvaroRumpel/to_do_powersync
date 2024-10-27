import 'package:powersync/powersync.dart';

const toDoTable = 'to_do';

final schema = const Schema(
  ([
    Table(
      toDoTable,
      [
        Column.text('task'),
        Column.integer('done'),
        Column.text('user_id'),
        Column.text('created_by'),
      ],
    ),
  ]),
);
