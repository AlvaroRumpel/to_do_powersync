import 'package:powersync/powersync.dart';

const toDoTable = 'to_do';
const userTable = 'user';

final schema = const Schema(
  ([
    Table(
      toDoTable,
      [
        Column.text('task'),
        Column.integer('done'),
        Column.text('user_id'),
        Column.text('created_at'),
        Column.text('deleted_at'),
      ],
    ),
    Table(
      userTable,
      [
        Column.text('email'),
        Column.text('deleted_at'),
        Column.text('created_at'),
      ],
    ),
  ]),
);
