// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../data/models/to_do_model.dart';

class ToDo {
  final String? id;
  final String task;
  final bool done;
  final String userId;
  final DateTime? createdAt;
  final DateTime? deletedAt;

  ToDo({
    this.id,
    required this.task,
    this.done = false,
    required this.userId,
    this.createdAt,
    this.deletedAt,
  });

  ToDo copyWith({
    String? id,
    String? task,
    bool? done,
    String? userId,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) {
    return ToDo(
      id: id ?? this.id,
      task: task ?? this.task,
      done: done ?? this.done,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  factory ToDo.fromModel(ToDoModel model) {
    return ToDo(
      id: model.id,
      task: model.task,
      userId: model.userId,
      createdAt: model.createdAt,
      deletedAt: model.deletedAt,
      done: model.done,
    );
  }
}
