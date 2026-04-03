// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_callsheet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCallsheetModelAdapter extends TypeAdapter<TaskCallsheetModel> {
  @override
  final int typeId = 20;

  @override
  TaskCallsheetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCallsheetModel(
      id: fields[0] as String,
      from: fields[1] as String,
      name: fields[2] as String,
      title: fields[3] as String,
      notes: fields[4] as String,
      isSynced: fields[5] as bool,
      isDeletedOffline: fields[6] as bool,
      pendingAction: fields[7] as String?,
      lastModified: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskCallsheetModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.from)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.isSynced)
      ..writeByte(6)
      ..write(obj.isDeletedOffline)
      ..writeByte(7)
      ..write(obj.pendingAction)
      ..writeByte(8)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCallsheetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
