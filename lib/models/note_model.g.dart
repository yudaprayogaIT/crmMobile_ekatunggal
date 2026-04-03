// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      id: fields[0] as String?,
      task: fields[1] as String?,
      doc: fields[2] as Doc?,
      customer: fields[3] as Branch?,
      topic: fields[4] as Branch?,
      tags: (fields[5] as List?)?.cast<Branch>(),
      result: fields[6] as String?,
      response: fields[7] as String?,
      createdBy: fields[8] as Branch?,
      createdAt: fields[9] as DateTime?,
      updatedAt: fields[10] as DateTime?,
      customerGroup: fields[11] as Branch?,
      branch: fields[12] as Branch?,
      isSynced: fields[13] as bool,
      isDeletedOffline: fields[14] as bool,
      pendingAction: fields[15] as String?,
      lastModified: fields[16] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.task)
      ..writeByte(2)
      ..write(obj.doc)
      ..writeByte(3)
      ..write(obj.customer)
      ..writeByte(4)
      ..write(obj.topic)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.result)
      ..writeByte(7)
      ..write(obj.response)
      ..writeByte(8)
      ..write(obj.createdBy)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.customerGroup)
      ..writeByte(12)
      ..write(obj.branch)
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
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BranchAdapter extends TypeAdapter<Branch> {
  @override
  final int typeId = 1;

  @override
  Branch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Branch(
      id: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Branch obj) {
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
      other is BranchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DocAdapter extends TypeAdapter<Doc> {
  @override
  final int typeId = 2;

  @override
  Doc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doc(
      type: fields[0] as String?,
      id: fields[1] as String?,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Doc obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
