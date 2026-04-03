// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoModelAdapter extends TypeAdapter<MemoModel> {
  @override
  final int typeId = 0;

  @override
  MemoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoModel(
      id: fields[0] as String,
      name: fields[1] as String,
      display: (fields[2] as List).cast<String>(),
      title: fields[3] as String,
      notes: fields[4] as String,
      status: fields[5] as String,
      workflowState: fields[6] as String,
      activeDate: fields[7] as DateTime,
      closingDate: fields[8] as DateTime,
      branch: (fields[9] as List).cast<dynamic>(),
      customerGroup: (fields[10] as List).cast<dynamic>(),
      userGroup: (fields[11] as List).cast<dynamic>(),
      createdBy: fields[12] as CreatedBy,
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
      isSynced: fields[15] as bool,
      isDeletedOffline: fields[16] as bool,
      pendingAction: fields[17] as String?,
      lastModified: fields[18] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MemoModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.display)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.workflowState)
      ..writeByte(7)
      ..write(obj.activeDate)
      ..writeByte(8)
      ..write(obj.closingDate)
      ..writeByte(9)
      ..write(obj.branch)
      ..writeByte(10)
      ..write(obj.customerGroup)
      ..writeByte(11)
      ..write(obj.userGroup)
      ..writeByte(12)
      ..write(obj.createdBy)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.isSynced)
      ..writeByte(16)
      ..write(obj.isDeletedOffline)
      ..writeByte(17)
      ..write(obj.pendingAction)
      ..writeByte(18)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CreatedByAdapter extends TypeAdapter<CreatedBy> {
  @override
  final int typeId = 1;

  @override
  CreatedBy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreatedBy(
      id: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreatedBy obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatedByAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
