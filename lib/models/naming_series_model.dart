import 'package:hive/hive.dart';

part 'naming_series_model.g.dart';

@HiveType(typeId: 0)
class NamingSeriesModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  List<BranchModel>? branch;

  @HiveField(3)
  String? doc;

  @HiveField(4)
  DateTime? createdAt;

  @HiveField(5)
  DateTime? updatedAt;

  @HiveField(6)
  String? status;

  @HiveField(7)
  String? workflowState;

  @HiveField(8)
  UserModel? createdBy;

  @HiveField(9)
  bool isSynced = false;

  @HiveField(10)
  bool isDeletedOffline = false;

  @HiveField(11)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(12)
  DateTime? lastModified;

  NamingSeriesModel({
    this.id,
    this.name,
    this.branch,
    this.doc,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.workflowState,
    this.createdBy,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory NamingSeriesModel.fromJson(Map<String, dynamic> json) {
    return NamingSeriesModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      branch: (json['branch'] as List<dynamic>?)
          ?.map((e) => BranchModel.fromJson(e))
          .toList(),
      doc: json['doc'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      status: json['status'],
      workflowState: json['workflowState'] as String?,
      createdBy: json['createdBy'] != null
          ? UserModel.fromJson(json['createdBy'])
          : null,
      isSynced: json['isSynced'] ?? false,
      isDeletedOffline: json['isDeletedOffline'] ?? false,
      pendingAction: json['pendingAction'],
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'branch': branch?.map((e) => e.toJson()).toList(),
      'doc': doc,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'status': status,
      'isSynced': isSynced,
      'isDeletedOffline': isDeletedOffline,
      'pendingAction': pendingAction,
      'workflowState': workflowState,
      'createdBy': createdBy?.toJson(),
    };
  }

  static List<NamingSeriesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NamingSeriesModel.fromJson(json)).toList();
  }
}

// ----------------------------
// BranchModel
// ----------------------------
@HiveType(typeId: 1)
class BranchModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  BranchModel({this.id, this.name});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

// ----------------------------
// UserModel
// ----------------------------
@HiveType(typeId: 2)
class UserModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  UserModel({this.id, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
