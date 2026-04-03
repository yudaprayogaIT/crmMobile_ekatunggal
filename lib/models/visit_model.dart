// ignore_for_file: prefer_if_null_operators

import 'package:hive/hive.dart';

part 'visit_model.g.dart';

@HiveType(typeId: 50)
class Visitmodel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? img;

  @HiveField(3)
  String? type;

  @HiveField(4)
  Customer? customer;

  @HiveField(5)
  Contact? contact;

  @HiveField(6)
  Check? checkIn;

  @HiveField(7)
  int? rate;

  @HiveField(8)
  Branch? createdBy;

  @HiveField(9)
  String? status;

  @HiveField(10)
  String? signature;

  @HiveField(11)
  String? workflowState;

  @HiveField(12)
  DateTime? updatedAt;

  @HiveField(13)
  Check? checkOut;

  @HiveField(14)
  Branch? customerGroup;

  @HiveField(15)
  Branch? branch;

  @HiveField(16)
  List<dynamic>? schedulelist;

  // Sync fields for Hive offline sync
  @HiveField(17)
  bool isSynced = false;

  @HiveField(18)
  bool isDeletedOffline = false;

  @HiveField(19)
  String? pendingAction; // create, update, delete

  @HiveField(20)
  DateTime? lastModified;

  Visitmodel({
    this.id,
    this.name,
    this.type,
    this.customer,
    this.contact,
    this.checkIn,
    this.rate,
    this.createdBy,
    this.status,
    this.workflowState,
    this.updatedAt,
    this.checkOut,
    this.customerGroup,
    this.branch,
    this.schedulelist,
    this.signature,
    this.img,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory Visitmodel.fromJson(Map<String, dynamic> json) {
    return Visitmodel(
      id: json["_id"],
      name: json["name"],
      img: json["img"] != null ? json["img"] : null,
      type: json["type"],
      customer: Customer.fromJson(json["customer"]),
      contact:
          json["contact"] != null ? Contact.fromJson(json["contact"]) : null,
      checkIn: Check.fromJson(json["checkIn"]),
      rate: json["rate"],
      createdBy: Branch.fromJson(json["createdBy"]),
      status: json["status"],
      signature: json["signature"] != null ? json["signature"] : null,
      workflowState: json["workflowState"],
      updatedAt: DateTime.parse(json["updatedAt"]),
      checkOut:
          json["checkOut"] != null ? Check.fromJson(json["checkOut"]) : null,
      customerGroup: Branch.fromJson(json["customerGroup"]),
      branch: Branch.fromJson(json["branch"]),
      schedulelist: json["schedulelist"] == null
          ? null
          : List<dynamic>.from(json["schedulelist"].map((x) => x)),
      // Sync fields from JSON if available (optional)
      isSynced: json['isSynced'] ?? false,
      isDeletedOffline: json['isDeletedOffline'] ?? false,
      pendingAction: json['pendingAction'],
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
    );
  }

  static List<Visitmodel> fromJsonList(List<dynamic> data) {
    try {
      if (data.isEmpty) return [];

      return data.map((e) => Visitmodel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "img": img,
        "type": type,
        "customer": customer!.toJson(),
        "contact": contact?.toJson(),
        "checkIn": checkIn!.toJson(),
        "rate": rate,
        "createdBy": createdBy!.toJson(),
        "status": status,
        "signature": signature,
        "workflowState": workflowState,
        "updatedAt": updatedAt!.toIso8601String(),
        "checkOut": checkOut?.toJson(),
        "customerGroup": customerGroup!.toJson(),
        "branch": branch!.toJson(),
        "schedulelist": schedulelist != null
            ? List<dynamic>.from(schedulelist!.map((x) => x))
            : null,
        "isSynced": isSynced,
        "isDeletedOffline": isDeletedOffline,
        "pendingAction": pendingAction,
        "lastModified": lastModified?.toIso8601String(),
      };
}

@HiveType(typeId: 51)
class Branch extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  Branch({
    required this.id,
    required this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

@HiveType(typeId: 52)
class Customer extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? erpId;

  Customer({
    required this.id,
    required this.name,
    this.erpId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        name: json["name"],
        erpId: json["erpId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "erpId": erpId,
      };
}

@HiveType(typeId: 53)
class Check extends HiveObject {
  @HiveField(0)
  DateTime? createdAt;

  @HiveField(1)
  double? lat;

  @HiveField(2)
  double? lng;

  @HiveField(3)
  String? address;

  Check({
    this.createdAt,
    this.lat,
    this.lng,
    this.address,
  });

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "lat": lat,
        "lng": lng,
        "address": address,
      };
}

@HiveType(typeId: 54)
class Contact extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int phone;

  @HiveField(3)
  String position;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.position,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "position": position,
      };
}
