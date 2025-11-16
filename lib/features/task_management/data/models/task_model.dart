import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/features/task_management/data/models/task_hive_ids.dart';

import '../../domain/entities/task.dart' as domain show Task;
import 'package:task_manager/core/utils/enums.dart';

enum PriorityModel { low, medium, high }
enum TaskStatusModel { todo, inProgress, done }
enum TaskGroupModel { work, study, gym, personal, other }

class PriorityModelAdapter extends TypeAdapter<PriorityModel> {
  @override
  final int typeId = HiveTypeIds.priority;
  @override
  PriorityModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PriorityModel.low;
      case 1:
        return PriorityModel.medium;
      case 2:
        return PriorityModel.high;
      default:
        return PriorityModel.medium;
    }
  }
  @override
  void write(BinaryWriter writer, PriorityModel obj) {
    switch (obj) {
      case PriorityModel.low:
        writer.writeByte(0);
        break;
      case PriorityModel.medium:
        writer.writeByte(1);
        break;
      case PriorityModel.high:
        writer.writeByte(2);
        break;
    }
  }
}

class TaskStatusModelAdapter extends TypeAdapter<TaskStatusModel> {
  @override
  final int typeId = HiveTypeIds.taskStatus;
  @override
  TaskStatusModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskStatusModel.todo;
      case 1:
        return TaskStatusModel.inProgress;
      case 2:
        return TaskStatusModel.done;
      default:
        return TaskStatusModel.todo;
    }
  }
  @override
  void write(BinaryWriter writer, TaskStatusModel obj) {
    switch (obj) {
      case TaskStatusModel.todo:
        writer.writeByte(0);
        break;
      case TaskStatusModel.inProgress:
        writer.writeByte(1);
        break;
      case TaskStatusModel.done:
        writer.writeByte(2);
        break;
    }
  }
}

class TaskGroupModelAdapter extends TypeAdapter<TaskGroupModel> {
  @override
  final int typeId = HiveTypeIds.taskGroup;
  @override
  TaskGroupModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskGroupModel.work;
      case 1:
        return TaskGroupModel.study;
      case 2:
        return TaskGroupModel.gym;
      case 3:
        return TaskGroupModel.personal;
      case 4:
        return TaskGroupModel.other;
      default:
        return TaskGroupModel.work;
    }
  }
  @override
  void write(BinaryWriter writer, TaskGroupModel obj) {
    switch (obj) {
      case TaskGroupModel.work:
        writer.writeByte(0);
        break;
      case TaskGroupModel.study:
        writer.writeByte(1);
        break;
      case TaskGroupModel.gym:
        writer.writeByte(2);
        break;
      case TaskGroupModel.personal:
        writer.writeByte(3);
        break;
      case TaskGroupModel.other:
        writer.writeByte(4);
        break;
    }
  }
}

class TaskModel extends HiveObject {
  String title;
  String? description;
  PriorityModel priority;
  bool isCompleted;
  DateTime createdAt;
  DateTime? startDate;
  DateTime? endDate;
  TaskGroupModel group;
  TaskStatusModel status;

  TaskModel({
    required this.title,
    this.description,
    this.priority = PriorityModel.medium,
    this.isCompleted = false,
    this.status = TaskStatusModel.todo,
    this.startDate,
    this.endDate,
    this.group = TaskGroupModel.work,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory TaskModel.fromDomain(domain.Task t) => TaskModel(
        title: t.title,
        description: t.description,
        priority: _priorityToModel(t.priority),
        isCompleted: t.isCompleted,
        status: _statusToModel(t.status),
        createdAt: t.createdAt,
        startDate: t.startDate,
        endDate: t.endDate,
        group: _groupToModel(t.group),
      );

  domain.Task toDomain() => domain.Task(
        title: title,
        description: description,
        priority: _priorityFromModel(priority),
        isCompleted: isCompleted,
        status: _statusFromModel(status),
        createdAt: createdAt,
        startDate: startDate,
        endDate: endDate,
        group: _groupFromModel(group),
      );
}

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = HiveTypeIds.task;
  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    final fallbackCompleted = fields[3] as bool? ?? false;
    final status = fields[8] as TaskStatusModel? ?? (fallbackCompleted ? TaskStatusModel.done : TaskStatusModel.todo);
    return TaskModel(
      title: fields[0] as String,
      description: fields[1] as String?,
      priority: fields[2] as PriorityModel? ?? PriorityModel.medium,
      isCompleted: fields[3] as bool? ?? false,
      createdAt: fields[4] as DateTime? ?? DateTime.now(),
      startDate: fields[5] as DateTime?,
      endDate: fields[6] as DateTime?,
      group: fields[7] as TaskGroupModel? ?? TaskGroupModel.work,
      status: status,
    );
  }
  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.priority)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.group)
      ..writeByte(8)
      ..write(obj.status);
  }
}

PriorityModel _priorityToModel(Priority p) => switch (p) {
      Priority.low => PriorityModel.low,
      Priority.medium => PriorityModel.medium,
      Priority.high => PriorityModel.high,
    };
Priority _priorityFromModel(PriorityModel p) => switch (p) {
      PriorityModel.low => Priority.low,
      PriorityModel.medium => Priority.medium,
      PriorityModel.high => Priority.high,
    };
TaskStatusModel _statusToModel(TaskStatus s) => switch (s) {
      TaskStatus.todo => TaskStatusModel.todo,
      TaskStatus.inProgress => TaskStatusModel.inProgress,
      TaskStatus.done => TaskStatusModel.done,
    };
TaskStatus _statusFromModel(TaskStatusModel s) => switch (s) {
      TaskStatusModel.todo => TaskStatus.todo,
      TaskStatusModel.inProgress => TaskStatus.inProgress,
      TaskStatusModel.done => TaskStatus.done,
    };
TaskGroupModel _groupToModel(TaskGroup g) => switch (g) {
      TaskGroup.work => TaskGroupModel.work,
      TaskGroup.study => TaskGroupModel.study,
      TaskGroup.gym => TaskGroupModel.gym,
      TaskGroup.personal => TaskGroupModel.personal,
      TaskGroup.other => TaskGroupModel.other,
    };
TaskGroup _groupFromModel(TaskGroupModel g) => switch (g) {
      TaskGroupModel.work => TaskGroup.work,
      TaskGroupModel.study => TaskGroup.study,
      TaskGroupModel.gym => TaskGroup.gym,
      TaskGroupModel.personal => TaskGroup.personal,
      TaskGroupModel.other => TaskGroup.other,
    };
