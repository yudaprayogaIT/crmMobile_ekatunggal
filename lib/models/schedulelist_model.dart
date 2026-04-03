import 'package:hive/hive.dart';

part 'schedulelist_model.g.dart';

@HiveType(typeId: 10)
class SchedulelistModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  Schedule? schedule;

  @HiveField(2)
  Customer? customer;

  @HiveField(3)
  CustomerGroup? customerGroup;

  @HiveField(4)
  Branch? branch;

  @HiveField(5)
  CreatedBy? createdBy;

  @HiveField(6)
  String? status;

  @HiveField(7)
  String? workflowState;

  @HiveField(8)
  DateTime? createdAt;

  @HiveField(9)
  DateTime? updatedAt;

  // Sync fields:
  @HiveField(10)
  bool isSynced;

  @HiveField(11)
  bool isDeletedOffline;

  @HiveField(12)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(13)
  DateTime? lastModified;

  SchedulelistModel({
    this.id,
    this.schedule,
    this.customer,
    this.customerGroup,
    this.branch,
    this.createdBy,
    this.status,
    this.workflowState,
    this.createdAt,
    this.updatedAt,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory SchedulelistModel.fromJson(Map<String, dynamic> json) =>
      SchedulelistModel(
        id: json['_id'],
        schedule: json['schedule'] != null
            ? Schedule.fromJson(json['schedule'])
            : null,
        customer: json['customer'] != null
            ? Customer.fromJson(json['customer'])
            : null,
        customerGroup: json['customerGroup'] != null
            ? CustomerGroup.fromJson(json['customerGroup'])
            : null,
        branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
        createdBy: json['createdBy'] != null
            ? CreatedBy.fromJson(json['createdBy'])
            : null,
        status: json['status'],
        workflowState: json['workflowState'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        isSynced: json['isSynced'] ?? false,
        isDeletedOffline: json['isDeletedOffline'] ?? false,
        pendingAction: json['pendingAction'],
        lastModified: json['lastModified'] != null
            ? DateTime.parse(json['lastModified'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'schedule': schedule?.toJson(),
        'customer': customer?.toJson(),
        'customerGroup': customerGroup?.toJson(),
        'branch': branch?.toJson(),
        'createdBy': createdBy?.toJson(),
        'status': status,
        'workflowState': workflowState,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'isSynced': isSynced,
        'isDeletedOffline': isDeletedOffline,
        'pendingAction': pendingAction,
        'lastModified': lastModified?.toIso8601String(),
      };

  static List<SchedulelistModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => SchedulelistModel.fromJson(json)).toList();
}

@HiveType(typeId: 11)
class Schedule extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String notes;

  @HiveField(3)
  String status;

  @HiveField(4)
  String workflowState;

  Schedule({
    this.id,
    this.name,
    this.notes = "",
    this.status = "",
    this.workflowState = "",
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json['_id'],
        name: json['name'],
        notes: json['notes'] ?? "",
        status: json['status'] ?? "",
        workflowState: json['workflowState'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'notes': notes,
        'status': status,
        'workflowState': workflowState,
      };
}

@HiveType(typeId: 12)
class CustomerGroup extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  CustomerGroup({this.id, this.name});

  factory CustomerGroup.fromJson(Map<String, dynamic> json) => CustomerGroup(
        id: json['_id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}

@HiveType(typeId: 13)
class Customer extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  Customer({this.id, this.name});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['_id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}

@HiveType(typeId: 14)
class Branch extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  Branch({this.id, this.name});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['_id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}

@HiveType(typeId: 15)
class CreatedBy extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  CreatedBy({this.id, this.name});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json['_id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}
