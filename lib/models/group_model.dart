import 'package:hive/hive.dart';

part 'group_model.g.dart'; // Jangan lupa generate dengan build_runner

@HiveType(typeId: 21)
class GroupModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  CreatedBy? parent;

  @HiveField(3)
  List<CreatedBy>? branch;

  @HiveField(4)
  CreatedBy? createdBy;

  @HiveField(5)
  String? status;

  @HiveField(6)
  String? workflowState;

  @HiveField(7)
  List<Child>? childs;

  // ==== Field tambahan untuk sync ====
  @HiveField(8)
  bool isSynced = false;

  @HiveField(9)
  bool isDeletedOffline = false;

  @HiveField(10)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(11)
  DateTime? lastModified;

  @HiveField(12)
  DateTime? createdAt;

  @HiveField(13)
  DateTime? updatedAt;

  GroupModel({
    this.id,
    this.name,
    this.parent,
    this.branch,
    this.createdBy,
    this.status,
    this.workflowState,
    this.childs,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["_id"],
        name: json["name"],
        parent:
            json["parent"] == null ? null : CreatedBy.fromJson(json["parent"]),
        branch: json["branch"] == null
            ? []
            : List<CreatedBy>.from(
                json["branch"]!.map((x) => CreatedBy.fromJson(x))),
        createdBy: json["createdBy"] == null
            ? null
            : CreatedBy.fromJson(json["createdBy"]),
        status: json["status"],
        workflowState: json["workflowState"],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        childs: json["childs"] == null
            ? []
            : List<Child>.from(json["childs"]!.map((x) => Child.fromJson(x))),
      );

  static List<GroupModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GroupModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "parent": parent?.toJson(),
        "branch": branch?.map((x) => x.toJson()).toList(),
        "createdBy": createdBy?.toJson(),
        "status": status,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        "workflowState": workflowState,
        'isSynced': isSynced,
        'isDeletedOffline': isDeletedOffline,
        'pendingAction': pendingAction,
        "childs": childs?.map((x) => x.toJson()).toList(),
      };
}

@HiveType(typeId: 22)
class CreatedBy extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  CreatedBy({
    this.id,
    this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

@HiveType(typeId: 23)
class Child extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  List<String>? branch;

  Child({
    this.id,
    this.name,
    this.branch,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["_id"],
        name: json["name"],
        branch: json["branch"] == null
            ? []
            : List<String>.from(json["branch"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "branch": branch ?? [],
      };
}
