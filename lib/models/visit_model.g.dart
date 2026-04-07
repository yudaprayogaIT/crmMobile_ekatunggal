// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitmodelAdapter extends TypeAdapter<Visitmodel> {
  @override
  final int typeId = 50;

  @override
  Visitmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Visitmodel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      type: fields[3] as String?,
      customer: fields[4] as Customer?,
      contact: fields[5] as Contact?,
      checkIn: fields[6] as Check?,
      rate: fields[7] as int?,
      createdBy: fields[8] as Branch?,
      status: fields[9] as String?,
      workflowState: fields[11] as String?,
      updatedAt: fields[12] as DateTime?,
      checkOut: fields[13] as Check?,
      customerGroup: fields[14] as Branch?,
      branch: fields[15] as Branch?,
      schedulelist: (fields[16] as List?)?.cast<dynamic>(),
      signature: fields[10] as String?,
      img: fields[2] as String?,
      isSynced: fields[17] as bool,
      isDeletedOffline: fields[18] as bool,
      pendingAction: fields[19] as String?,
      lastModified: fields[20] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Visitmodel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.customer)
      ..writeByte(5)
      ..write(obj.contact)
      ..writeByte(6)
      ..write(obj.checkIn)
      ..writeByte(7)
      ..write(obj.rate)
      ..writeByte(8)
      ..write(obj.createdBy)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.signature)
      ..writeByte(11)
      ..write(obj.workflowState)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.checkOut)
      ..writeByte(14)
      ..write(obj.customerGroup)
      ..writeByte(15)
      ..write(obj.branch)
      ..writeByte(16)
      ..write(obj.schedulelist)
      ..writeByte(17)
      ..write(obj.isSynced)
      ..writeByte(18)
      ..write(obj.isDeletedOffline)
      ..writeByte(19)
      ..write(obj.pendingAction)
      ..writeByte(20)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BranchAdapter extends TypeAdapter<Branch> {
  @override
  final int typeId = 51;

  @override
  Branch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Branch(
      id: fields[0] as String,
      name: fields[1] as String,
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

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 52;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      id: fields[0] as String,
      name: fields[1] as String,
      erpId: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.erpId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CheckAdapter extends TypeAdapter<Check> {
  @override
  final int typeId = 53;

  @override
  Check read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Check(
      createdAt: fields[0] as DateTime?,
      lat: fields[1] as double?,
      lng: fields[2] as double?,
      address: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Check obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lng)
      ..writeByte(3)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 54;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      id: fields[0] as String,
      name: fields[1] as String,
      phone: fields[2] as String,
      position: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
