import 'package:hive/hive.dart';

part 'memo_model.g.dart';

@HiveType(typeId: 0)
class MemoModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<String> display;

  @HiveField(3)
  String title;

  @HiveField(4)
  String notes;

  @HiveField(5)
  String status;

  @HiveField(6)
  String workflowState;

  @HiveField(7)
  DateTime activeDate;

  @HiveField(8)
  DateTime closingDate;

  @HiveField(9)
  List<dynamic> branch;

  @HiveField(10)
  List<dynamic> customerGroup;

  @HiveField(11)
  List<dynamic> userGroup;

  @HiveField(12)
  CreatedBy createdBy;

  @HiveField(13)
  DateTime createdAt;

  @HiveField(14)
  DateTime updatedAt;

  // SYNC SUPPORT
  @HiveField(15)
  bool isSynced;

  @HiveField(16)
  bool isDeletedOffline;

  @HiveField(17)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(18)
  DateTime? lastModified;

  MemoModel({
    required this.id,
    required this.name,
    required this.display,
    required this.title,
    required this.notes,
    required this.status,
    required this.workflowState,
    required this.activeDate,
    required this.closingDate,
    required this.branch,
    required this.customerGroup,
    required this.userGroup,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory MemoModel.fromJson(Map<String, dynamic> json) => MemoModel(
        id: json["_id"],
        name: json["name"],
        display: List<String>.from(json["display"] ?? []),
        title: json["title"],
        notes: json["notes"],
        status: json["status"],
        workflowState: json["workflowState"],
        activeDate: DateTime.parse(json["activeDate"]),
        closingDate: DateTime.parse(json["closingDate"]),
        branch: List<dynamic>.from(json["branch"] ?? []),
        customerGroup: List<dynamic>.from(json["customerGroup"] ?? []),
        userGroup: List<dynamic>.from(json["userGroup"] ?? []),
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "display": display,
        "title": title,
        "notes": notes,
        "status": status,
        "workflowState": workflowState,
        "activeDate": activeDate.toIso8601String(),
        "closingDate": closingDate.toIso8601String(),
        "branch": branch,
        "customerGroup": customerGroup,
        "userGroup": userGroup,
        "createdBy": createdBy.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

@HiveType(typeId: 1)
class CreatedBy extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  CreatedBy({
    required this.id,
    required this.name,
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
