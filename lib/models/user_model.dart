import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 22)
class UserModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? username;

  @HiveField(3)
  String? img;

  @HiveField(4)
  String? email;

  @HiveField(5)
  num? phone;

  @HiveField(6)
  String? status;

  @HiveField(7)
  String? workflowState;

  @HiveField(8)
  DateTime? createdAt;

  @HiveField(9)
  DateTime? updatedAt;

  @HiveField(10)
  int? v;

  @HiveField(11)
  String? erpSite;

  @HiveField(12)
  String? erpToken;

  // Sync fields
  @HiveField(13)
  bool isSynced;

  @HiveField(14)
  bool isDeletedOffline;

  @HiveField(15)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(16)
  DateTime? lastModified;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.img,
    this.email,
    this.phone,
    this.status,
    this.workflowState,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.erpSite,
    this.erpToken,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        phone: json["phone"],
        img: json["img"],
        email: json["email"],
        status: json["status"],
        workflowState: json["workflowState"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        erpSite: json["ErpSite"],
        erpToken: json["ErpToken"],
        // Default sync fields, can be customized if present in JSON:
        isSynced: json["isSynced"] ?? false,
        isDeletedOffline: json["isDeletedOffline"] ?? false,
        pendingAction: json["pendingAction"],
        lastModified: json["lastModified"] != null
            ? DateTime.parse(json["lastModified"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "img": img,
        "email": email,
        "phone": phone,
        "username": username,
        "status": status,
        "workflowState": workflowState,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "ErpSite": erpSite,
        "ErpToken": erpToken,
        "isSynced": isSynced,
        "isDeletedOffline": isDeletedOffline,
        "pendingAction": pendingAction,
        "lastModified": lastModified?.toIso8601String(),
      };
}
