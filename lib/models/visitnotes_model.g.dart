// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitnotes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitNoteModelAdapter extends TypeAdapter<VisitNoteModel> {
  @override
  final int typeId = 60;

  @override
  VisitNoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VisitNoteModel(
      id: fields[0] as String,
      title: fields[1] as String,
      visit: fields[2] as String,
      tags: (fields[3] as List)
          .map((dynamic e) => (e as Map).cast<dynamic, dynamic>())
          .toList(),
      notes: fields[4] as String,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      isSynced: fields[7] as bool,
      isDeletedOffline: fields[8] as bool,
      pendingAction: fields[9] as String?,
      lastModified: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, VisitNoteModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.visit)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.isSynced)
      ..writeByte(8)
      ..write(obj.isDeletedOffline)
      ..writeByte(9)
      ..write(obj.pendingAction)
      ..writeByte(10)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitNoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
