import 'package:hive/hive.dart';

part 'branch_model.g.dart';

@HiveType(typeId: 24)
class BranchModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  CreatedBy? createdBy;

  @HiveField(3)
  String? status;

  @HiveField(4)
  String? workflowState;

  @HiveField(5)
  DateTime? updatedAt;

  @HiveField(6)
  bool isSynced = false;

  @HiveField(7)
  bool isDeletedOffline = false;

  @HiveField(8)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(9)
  DateTime? lastModified;

  @HiveField(10)
  DateTime? createdAt;

  BranchModel({
    this.id,
    this.name,
    this.createdBy,
    this.status,
    this.workflowState,
    this.updatedAt,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
    this.createdAt,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json['_id'],
        name: json['name'],
        createdBy: json['createdBy'] != null
            ? CreatedBy.fromJson(json['createdBy'])
            : null,
        status: json['status'],
        workflowState: json['workflowState'],
        isSynced: json['isSynced'] ?? false,
        isDeletedOffline: json['isDeletedOffline'] ?? false,
        pendingAction: json['pendingAction'],
        lastModified: json['lastModified'] != null
            ? DateTime.parse(json['lastModified'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'createdBy': createdBy?.toJson(),
        'status': status,
        'isSynced': isSynced,
        'isDeletedOffline': isDeletedOffline,
        'pendingAction': pendingAction,
        'lastModified': lastModified?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'workflowState': workflowState,
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

@HiveType(typeId: 25)
class CreatedBy {
  @HiveField(0)
  String? name;

  CreatedBy({this.name});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
