// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 22;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      username: fields[2] as String?,
      img: fields[3] as String?,
      email: fields[4] as String?,
      phone: fields[5] as String?,
      status: fields[6] as String?,
      workflowState: fields[7] as String?,
      createdAt: fields[8] as DateTime?,
      updatedAt: fields[9] as DateTime?,
      v: fields[10] as int?,
      erpSite: fields[11] as String?,
      erpToken: fields[12] as String?,
      isSynced: fields[13] as bool,
      isDeletedOffline: fields[14] as bool,
      pendingAction: fields[15] as String?,
      lastModified: fields[16] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.img)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.workflowState)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.v)
      ..writeByte(11)
      ..write(obj.erpSite)
      ..writeByte(12)
      ..write(obj.erpToken)
      ..writeByte(13)
      ..write(obj.isSynced)
      ..writeByte(14)
      ..write(obj.isDeletedOffline)
      ..writeByte(15)
      ..write(obj.pendingAction)
      ..writeByte(16)
      ..write(obj.lastModified);
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
