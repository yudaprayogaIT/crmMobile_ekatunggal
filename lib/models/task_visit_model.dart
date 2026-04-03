import 'package:hive/hive.dart';

part 'task_visit_model.g.dart';

@HiveType(typeId: 21)
class TaskVisitModel extends HiveObject {
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

  // Sync fields
  @HiveField(5)
  bool isSynced;

  @HiveField(6)
  bool isDeletedOffline;

  @HiveField(7)
  String? pendingAction; // create, update, delete

  @HiveField(8)
  DateTime? lastModified;

  TaskVisitModel({
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

  factory TaskVisitModel.fromJson(Map<String, dynamic> json) {
    return TaskVisitModel(
      id: json['_id'] ?? '',
      from: json['from'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      notes: json['notes'] ?? '',
      isSynced: json['isSynced'] ?? false,
      isDeletedOffline: json['isDeletedOffline'] ?? false,
      pendingAction: json['pendingAction'],
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
    );
  }

  static List<TaskVisitModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskVisitModel.fromJson(json)).toList();
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
