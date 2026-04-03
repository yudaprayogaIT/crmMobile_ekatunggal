// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BranchModelAdapter extends TypeAdapter<BranchModel> {
  @override
  final int typeId = 24;

  @override
  BranchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BranchModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      createdBy: fields[2] as CreatedBy?,
      status: fields[3] as String?,
      workflowState: fields[4] as String?,
      updatedAt: fields[5] as DateTime?,
      isSynced: fields[6] as bool,
      isDeletedOffline: fields[7] as bool,
      pendingAction: fields[8] as String?,
      lastModified: fields[9] as DateTime?,
      createdAt: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BranchModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdBy)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.workflowState)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.isSynced)
      ..writeByte(7)
      ..write(obj.isDeletedOffline)
      ..writeByte(8)
      ..write(obj.pendingAction)
      ..writeByte(9)
      ..write(obj.lastModified)
      ..writeByte(10)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CreatedByAdapter extends TypeAdapter<CreatedBy> {
  @override
  final int typeId = 25;

  @override
  CreatedBy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreatedBy(
      name: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CreatedBy obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
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
