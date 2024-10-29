import 'dart:convert';

import 'package:powersync/sqlite3_common.dart';

import '../../domain/entities/to_do.dart';

@override
String get toDoTable => 'to_do';

class ToDoModel {
  final String? id;
  final String task;
  final bool done;
  final String userId;
  final DateTime? createdAt;
  final DateTime? deletedAt;

  ToDoModel({
    this.id,
    required this.task,
    required this.done,
    required this.userId,
    this.createdAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
      'done': done,
      'user_id': userId,
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  Map<String, String> toDB() {
    return <String, String>{
      'id': 'uuid()',
      'created_at': 'datetime()',
      'done': done ? 'TRUE' : 'FALSE',
      'task': '?',
      'user_id': '?',
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'],
      task: map['task'] as String,
      done: map['done'] is bool ? map['done'] : map['done'] == 1,
      userId: map['user_id'] as String,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      deletedAt: map['deleted_at'] != null
          ? DateTime.tryParse(map['deleted_at'])
          : null,
    );
  }

  factory ToDoModel.fromRow(Row row) {
    return ToDoModel(
      id: row['id'],
      task: row['task'],
      done: row['done'] == 1,
      userId: row['user_id'],
      createdAt: row['created_at'] != null
          ? DateTime.tryParse(row['created_at'])
          : null,
      deletedAt: row['deleted_at'] != null
          ? DateTime.tryParse(row['deleted_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoModel.fromJson(String source) =>
      ToDoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ToDoModel copyWith({
    String? id,
    String? task,
    bool? done,
    String? userId,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) {
    return ToDoModel(
      id: id ?? this.id,
      task: task ?? this.task,
      done: done ?? this.done,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  factory ToDoModel.fromEntity(ToDo entity) {
    return ToDoModel(
      id: entity.id,
      task: entity.task,
      done: entity.done,
      userId: entity.userId,
      createdAt: entity.createdAt,
      deletedAt: entity.deletedAt,
    );
  }
}
