// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'naming_series_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NamingSeriesModelAdapter extends TypeAdapter<NamingSeriesModel> {
  @override
  final int typeId = 0;

  @override
  NamingSeriesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NamingSeriesModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      branch: (fields[2] as List?)?.cast<BranchModel>(),
      doc: fields[3] as String?,
      createdAt: fields[4] as DateTime?,
      updatedAt: fields[5] as DateTime?,
      status: fields[6] as String?,
      workflowState: fields[7] as String?,
      createdBy: fields[8] as UserModel?,
      isSynced: fields[9] as bool,
      isDeletedOffline: fields[10] as bool,
      pendingAction: fields[11] as String?,
      lastModified: fields[12] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NamingSeriesModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.branch)
      ..writeByte(3)
      ..write(obj.doc)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.workflowState)
      ..writeByte(8)
      ..write(obj.createdBy)
      ..writeByte(9)
      ..write(obj.isSynced)
      ..writeByte(10)
      ..write(obj.isDeletedOffline)
      ..writeByte(11)
      ..write(obj.pendingAction)
      ..writeByte(12)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NamingSeriesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BranchModelAdapter extends TypeAdapter<BranchModel> {
  @override
  final int typeId = 1;

  @override
  BranchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BranchModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BranchModel obj) {
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
      other is BranchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 2;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
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
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
