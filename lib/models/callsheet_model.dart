import 'package:hive/hive.dart';

part 'callsheet_model.g.dart';

@HiveType(typeId: 20)
class CallsheetModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? type;

  @HiveField(3)
  Customer? customer;

  @HiveField(4)
  Contact? contact;

  @HiveField(5)
  num? rate;

  @HiveField(6)
  Branch? createdBy;

  @HiveField(7)
  String? status;

  @HiveField(8)
  String? workflowState;

  @HiveField(9)
  DateTime? createdAt;

  @HiveField(10)
  DateTime? updatedAt;

  @HiveField(11)
  Branch? customerGroup;

  @HiveField(12)
  Branch? branch;

  @HiveField(13)
  List<dynamic>? schedulelist;

  // Sync fields
  @HiveField(14)
  bool isSynced = false;

  @HiveField(15)
  bool isDeletedOffline = false;

  @HiveField(16)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(17)
  DateTime? lastModified;

  CallsheetModel({
    this.id,
    this.name,
    this.type,
    this.customer,
    this.contact,
    this.rate,
    this.createdBy,
    this.status,
    this.workflowState,
    this.createdAt,
    this.updatedAt,
    this.customerGroup,
    this.branch,
    this.schedulelist,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory CallsheetModel.fromJson(Map<String, dynamic> json) => CallsheetModel(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        rate: json["rate"],
        createdBy: json["createdBy"] == null
            ? null
            : Branch.fromJson(json["createdBy"]),
        status: json["status"],
        workflowState: json["workflowState"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        customerGroup: json["customerGroup"] == null
            ? null
            : Branch.fromJson(json["customerGroup"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        schedulelist: json["schedulelist"] == null
            ? []
            : List<dynamic>.from(json["schedulelist"]!.map((x) => x)),
        isSynced: json['isSynced'] ?? false,
        isDeletedOffline: json['isDeletedOffline'] ?? false,
        pendingAction: json['pendingAction'],
        lastModified: json['lastModified'] != null
            ? DateTime.parse(json['lastModified'])
            : null,
      );

  static List<CallsheetModel> fromJsonList(List<dynamic> data) {
    try {
      if (data.isEmpty) return [];

      return data.map((e) => CallsheetModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "customer": customer?.toJson(),
        "contact": contact?.toJson(),
        "rate": rate,
        "createdBy": createdBy?.toJson(),
        "status": status,
        "workflowState": workflowState,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "customerGroup": customerGroup?.toJson(),
        "branch": branch?.toJson(),
        "schedulelist": schedulelist == null
            ? []
            : List<dynamic>.from(schedulelist!.map((x) => x)),
        'isSynced': isSynced,
        'isDeletedOffline': isDeletedOffline,
        'pendingAction': pendingAction,
        'lastModified': lastModified?.toIso8601String(),
      };
}

@HiveType(typeId: 21)
class Branch extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  Branch({
    this.id,
    this.name,
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

@HiveType(typeId: 22)
class Customer extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? erpId;

  Customer({
    this.id,
    this.name,
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

@HiveType(typeId: 23)
class Contact extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? position;

  @HiveField(3)
  String? phone;

  Contact({
    this.id,
    this.name,
    this.phone,
    this.position,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"]?.toString(),
        position: json["position"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "position": position,
      };
}
