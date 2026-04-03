import 'package:hive/hive.dart';

part 'task_callsheet_model.g.dart';

@HiveType(typeId: 20)
class TaskCallsheetModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String from;

  @HiveField(2)
  String name;

  @HiveField(3)
  String title;

  @HiveField(4)
  String notes;

  // Sync related fields
  @HiveField(5)
  bool isSynced;

  @HiveField(6)
  bool isDeletedOffline;

  @HiveField(7)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(8)
  DateTime? lastModified;

  TaskCallsheetModel({
    required this.id,
    required this.from,
    required this.name,
    required this.title,
    required this.notes,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory TaskCallsheetModel.fromJson(Map<String, dynamic> json) {
    return TaskCallsheetModel(
      id: json['_id'],
      from: json['from'],
      name: json['name'],
      title: json['title'],
      notes: json['notes'],
      isSynced: json['isSynced'] ?? false,
      isDeletedOffline: json['isDeletedOffline'] ?? false,
      pendingAction: json['pendingAction'],
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
    );
  }

  static List<TaskCallsheetModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskCallsheetModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'from': from,
      'name': name,
      'title': title,
      'notes': notes,
      'isSynced': isSynced,
      'isDeletedOffline': isDeletedOffline,
      'pendingAction': pendingAction,
      'lastModified': lastModified?.toIso8601String(),
    };
  }
}
